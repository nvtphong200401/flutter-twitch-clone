import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';

class MessageController extends ChangeNotifier {
  IOWebSocketChannel connection;
  late String channel;
  MessageController({required this.connection});

  void connect(String channel, String account, String password) {
    connection.sink.add('CAP REQ :twitch.tv/commands twitch.tv/membership twitch.tv/tags');
    connection.sink.add('PASS oauth:$password');
    connection.sink.add('NICK $account');
    this.channel = channel;
  }
  void sendMessage(String message){
    connection.sink.add('PRIVMSG $channel :$message');
    print('sent message: $message');
  }

  Map handleMessage(String ircMessage) {
    String rawIrcMessage = ircMessage.trimRight();
    final result = {};
    var messages = rawIrcMessage
        .split('\r\n'); // The IRC message may contain one or more messages.
    messages.forEach((message) {
      var parsedMessage = parseMessage(message);
      if(parsedMessage != null){

        //result['color'] = parsedMessage['tags']['color'] ?? '#808080';
      }

      if (parsedMessage != null) {
        // console.log('Message command: ${parsedMessage.command.command}');
        // console.log('\n${JSON.stringify(parsedMessage, null, 3)}')
        print('parsedMessage $parsedMessage');
        switch (parsedMessage['command']['command']) {
          case 'PRIVMSG':
            result['nick'] = parsedMessage['source']['nick'];
            result['content'] = parsedMessage['parameters'];
            if(parsedMessage['tags'] != null){
              result['color'] = parsedMessage['tags']['color'] ?? '#808080';
            }
            else {
              result['color'] = '#808080';
            }
          // Ignore all messages except the '!move' bot
          // command. A user can post a !move command to change the
          // interval for when the bot posts its move message.

            break;
          case 'PING':
            connection.sink.add('PONG ' + parsedMessage['parameters']);
            break;
          case '001':
          // Successfully logged in, so join the channel.
            connection.sink.add('JOIN ${channel}');
            break;
          case 'JOIN':
          // Send the initial move message. All other move messages are
          // sent by the timer.
            connection.sink.add(
                'PRIVMSG ${channel} : Get up and move, your body will thank you!');
            break;
          case 'PART':
            connection.sink.close();
            break;
          case 'NOTICE':
            if(parsedMessage['tags'] != null){
              result['msg-id'] = parsedMessage['tags']['msg-id'];
            }
          // If the authentication failed, leave the channel.
          // The server will close the connection.
            if ('Login authentication failed' == parsedMessage['parameters']) {
              connection.sink.add('PART ${channel}');
            } else if ('You don’t have permission to perform that action' ==
                parsedMessage['parameters']) {
              connection.sink.add('PART ${channel}');
            }
            break;
          default:
            ; // Ignore all other IRC messages.
        }
      }
    });
    return result;
  }

  Map<String, dynamic>? parseMessage(String message) {
    Map<String, dynamic> parsedMessage = {
      // Contains the component parts.
      'tags': null,
      'source': null,
      'command': null,
      'parameters': null
    };

    // The start index. Increments as we parse the IRC message.

    int idx = 0;

    // The raw components of the IRC message.

    var rawTagsComponent = null;
    var rawSourceComponent = null;
    var rawCommandComponent = null;
    var rawParametersComponent = null;

    // If the message includes tags, get the tags component of the IRC message.

    if (message[idx] == '@') {
      // The message includes tags.
      int endIdx = message.indexOf(' ').toInt();
      rawTagsComponent = message.substring(1, endIdx);
      idx = endIdx + 1; // Should now point to source colon (:).
    }

    // Get the source component (nick and host) of the IRC message.
    // The idx should point to the source part; otherwise, it's a PING command.

    if (message[idx] == ':') {
      idx += 1;
      int endIdx = message.indexOf(' ', idx).toInt();
      rawSourceComponent = message.substring(idx, endIdx);
      idx = endIdx + 1; // Should point to the command part of the message.
    }

    // Get the command component of the IRC message.

    int endIdx = message.indexOf(
        ':', idx).toInt(); // Looking for the parameters part of the message.
    if (-1 == endIdx) {
      // But not all messages include the parameters part.
      endIdx = message.length;
    }

    rawCommandComponent = message.substring(idx, endIdx).trim();

    // Get the parameters component of the IRC message.

    if (endIdx != message.length) {
      // Check if the IRC message contains a parameters component.
      idx = endIdx + 1; // Should point to the parameters part of the message.
      rawParametersComponent = message.substring(idx);
    }

    // Parse the command component of the IRC message.

    parsedMessage['command'] = parseCommand(rawCommandComponent);

    // Only parse the rest of the components if it's a command
    // we care about; we ignore some messages.

    if (parsedMessage['command'] == null) {
      return null;
    } else {
      if (null != rawTagsComponent) {
        // The IRC message contains tags.
        parsedMessage['tags'] = parseTags(rawTagsComponent);
      }

      parsedMessage['source'] = parseSource(rawSourceComponent);

      parsedMessage['parameters'] = rawParametersComponent;
      if (rawParametersComponent != null && rawParametersComponent[0] == '!') {
        // The user entered a bot command in the chat window.
        parsedMessage['command'] =
            parseParameters(rawParametersComponent, parsedMessage['command']);
      }
    }

    return parsedMessage;
  }

// Parses the tags component of the IRC message.

  parseTags(String tags) {
    // badge-info=;badges=broadcaster/1;color=#0000FF;...

    const Map<String, dynamic> tagsToIgnore = {
      // List of tags to ignore.
      'client-nonce': null,
      'flags': null
    };

    var dictParsedTags = {}; // Holds the parsed list of tags.
    // The key is the tag's name (e.g., color).
    var parsedTags = tags.split(';');

    parsedTags.forEach((tag) {
      var parsedTag = tag.split('='); // Tags are key/value pairs.
      var tagValue = (parsedTag[1] == '') ? null : parsedTag[1];

      switch (parsedTag[0]) {
      // Switch on tag name
        case 'badges':
        case 'badge-info':
        // badges=staff/1,broadcaster/1,turbo/1;

          if (tagValue != null) {
            var dict = {}; // Holds the list of badge objects.
            // The key is the badge's name (e.g., subscriber).
            var badges = tagValue.split(',');
            badges.forEach((pair) {
              var badgeParts = pair.split('/');
              dict[badgeParts[0]] = badgeParts[1];
            });

            dictParsedTags[parsedTag[0]] = dict;
          } else {
            dictParsedTags[parsedTag[0]] = null;
          }
          break;
        case 'emotes':
        // emotes=25:0-4,12-16/1902:6-10

          if (tagValue != null) {
            var dictEmotes = {}; // Holds a list of emote objects.
            // The key is the emote's ID.
            var emotes = tagValue.split('/');
            emotes.forEach((emote) {
              var emoteParts = emote.split(':');

              var textPositions =
              []; // The list of position objects that identify
              // the location of the emote in the chat message.
              var positions = emoteParts[1].split(',');
              positions.forEach((position) {
                var positionParts = position.split('-');
                textPositions.add({
                  'startPosition': positionParts[0],
                  'endPosition': positionParts[1]
                });
              });

              dictEmotes[emoteParts[0]] = textPositions;
            });

            dictParsedTags[parsedTag[0]] = dictEmotes;
          } else {
            dictParsedTags[parsedTag[0]] = null;
          }

          break;
        case 'emote-sets':
        // emote-sets=0,33,50,237

          var emoteSetIds = tagValue?.split(','); // Array of emote set IDs.
          dictParsedTags[parsedTag[0]] = emoteSetIds;
          break;
        default:
        // If the tag is in the list of tags to ignore, ignore
        // it; otherwise, add it.

          if (tagsToIgnore[parsedTag[0]] != null) {
          } else {
            dictParsedTags[parsedTag[0]] = tagValue;
          }
      }
    });

    return dictParsedTags;
  }

// Parses the command component of the IRC message.

  Map<String, dynamic>? parseCommand(rawCommandComponent) {
    var parsedCommand = null;
    var commandParts = rawCommandComponent.split(' ');

    switch (commandParts[0]) {
      case 'JOIN':
      case 'PART':
      case 'NOTICE':
      case 'CLEARCHAT':
      case 'HOSTTARGET':
      case 'PRIVMSG':
        parsedCommand = {
          'command': commandParts[0],
          'channel': commandParts[1]
        };
        break;
      case 'PING':
        parsedCommand = {'command': commandParts[0]};
        break;
      case 'CAP':
        parsedCommand = {
          'command': commandParts[0],
          'isCapRequestEnabled': (commandParts[2] == 'ACK') ? true : false,
          // The parameters part of the messages contains the
          // enabled capabilities.
        };
        break;
      case 'GLOBALUSERSTATE': // Included only if you request the /commands capability.
      // But it has no meaning without also including the /tags capability.
        parsedCommand = {'command': commandParts[0]};
        break;
      case 'USERSTATE': // Included only if you request the /commands capability.
      case 'ROOMSTATE': // But it has no meaning without also including the /tags capabilities.
        parsedCommand = {
          'command': commandParts[0],
          'channel': commandParts[1]
        };
        break;
      case 'RECONNECT':
        parsedCommand = {'command': commandParts[0]};
        break;
      case '421':
        return null;
      case '001': // Logged in (successfully authenticated).
        parsedCommand = {
          'command': commandParts[0],
          'channel': commandParts[1]
        };
        break;
      case '002': // Ignoring all other numeric messages.
      case '003':
      case '004':
      case '353': // Tells you who else is in the chat room you're joining.
      case '366':
      case '372':
      case '375':
      case '376':
        return null;
      default:
        return null;
    }

    return parsedCommand;
  }

// Parses the source (nick and host) components of the IRC message.

  parseSource(rawSourceComponent) {
    if (null == rawSourceComponent) {
      // Not all messages contain a source
      return null;
    } else {
      var sourceParts = rawSourceComponent.split('!');
      return {
        'nick': (sourceParts.length == 2) ? sourceParts[0] : null,
        'host': (sourceParts.length == 2) ? sourceParts[1] : sourceParts[0]
      };
    }
  }

// Parsing the IRC parameters component if it contains a command (e.g., !dice).

  parseParameters(String rawParametersComponent, Map command) {
    var idx = 0;
    var commandParts = rawParametersComponent.substring(idx + 1).trim();
    var paramsIdx = commandParts.indexOf(' ');

    if (-1 == paramsIdx) {
      // no parameters
      command['botCommand'] = commandParts.substring(0);
    } else {
      command['botCommand'] = commandParts.substring(0, paramsIdx);
      command['botCommandParams'] = commandParts.substring(paramsIdx).trim();
      // TODO: remove extra spaces in parameters string
    }

    return command;
  }
}