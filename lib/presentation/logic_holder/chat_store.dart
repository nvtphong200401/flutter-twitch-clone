import 'package:flutter/material.dart';
import 'package:flutter_twitch_clone/domain/auth_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatStore {
  WebSocketChannel _channel =
      WebSocketChannel.connect(Uri.parse('wss://irc-ws.chat.twitch.tv:443'));
  final String? login;
  final String? channelName;
  final textController = TextEditingController();
  final scrollController = ScrollController();
  var _autoScroll = true;
  var _showAutocomplete = false;
  final textFieldFocusNode = FocusNode();

  ChatStore({required this.login, required this.channelName}) {
    scrollController.addListener(() {
      // If the user scrolls up, auto-scroll will stop, allowing them to freely scroll back to previous messages.
      // Else if the user scrolls back to the bottom edge (latest message), auto-scroll will resume.
      if (scrollController.position.pixels <
          scrollController.position.maxScrollExtent) {
        if (_autoScroll == true) _autoScroll = false;
      } else if (scrollController.position.atEdge ||
          scrollController.position.pixels >
              scrollController.position.maxScrollExtent) {
        if (_autoScroll == false) _autoScroll = true;
      }
    });

    textController.addListener(() => _showAutocomplete =
        textFieldFocusNode.hasFocus &&
                textController.text.split(' ').last.isNotEmpty
            ? true
            : false);
  }

  void connectToChat() {
    _channel.sink.close(1001);
    _channel =
        WebSocketChannel.connect(Uri.parse('wss://irc-ws.chat.twitch.tv:443'));

    // Listen for new messages and forward them to the handler.
    _channel.stream.listen(
      (data) => Future.delayed(const Duration(seconds: 0), () {
        print(data.toString());
        _handleIRCData(data.toString());
      }),
      onError: (error) => print('Chat error: ${error.toString()}'),
      onDone: () async {
        if (_channel == null) return;
      },
    );

    // The list of messages sent to the IRC WebSocket channel to connect and join.
    final commands = [
      // Request the tags and commands capabilities.
      // This will display tags containing metadata along with each IRC message.
      'CAP REQ :twitch.tv/tags twitch.tv/commands',

      // The OAuth token in order to connect, default or user token.
      'PASS oauth:${AuthController.header['Authorization']?.split(' ')[1]}',

      // The nickname for the connecting user. 'justinfan888' is the Twitch default if not logged in.
      'NICK ${login ?? 'justinfan888'}',

      // Join the desired channel's room.
      'JOIN #$channelName',
    ];

    // Send each command in order.
    for (final command in commands) {
      _channel.sink.add(command);
    }
  }

  void sendMessage(String message) {
    // Do not send if the message is blank/empty.
    if (message.isEmpty) return;

    // Send the message to the IRC chat room.
    _channel.sink.add('PRIVMSG #$channelName :$message');

    // Clear the previous input in the TextField.
    textController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  void _handleIRCData(String data) {
    // The IRC data can contain more than one message separated by CRLF.
    // To account for this, split by CRLF, then loop and process each message.
    for (final message in data.trimRight().split('\r\n')) {
      // debugPrint(message);

      // Hard upper-limit of 5000 messages to prevent infinite messages being added when scrolling.
      if (message == 'PING :tmi.twitch.tv') {
        _channel.sink.add('PONG :tmi.twitch.tv');
        return;
      }
    }
  }
}

//final chatStore = Provider((ref) => ChatStore(login: 'nvtphong', channelName: 'loud_coringa'));
