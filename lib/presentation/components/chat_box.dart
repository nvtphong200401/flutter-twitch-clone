import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/core/custom_pipview/pip_view.dart';
import 'package:flutter_twitch_clone/data/models/stream_model.dart';
import 'package:flutter_twitch_clone/domain/auth_controller.dart';
import 'package:flutter_twitch_clone/domain/event_controller.dart';
import 'package:flutter_twitch_clone/domain/message_controller.dart';
import 'package:flutter_twitch_clone/domain/noti_controller.dart';

import '../../core/constant.dart';
import '../DI.dart';

class ChatBox extends ConsumerStatefulWidget {
  const ChatBox({Key? key, required this.streamModel}) : super(key: key);
  final StreamModel streamModel;

  @override
  ConsumerState createState() => _ChatBoxState();
}

class _ChatBoxState extends ConsumerState<ChatBox> {
  final scrollController = ScrollController();
  final message = [];

  @override
  Widget build(BuildContext context) {
    final MessageController messageProvider =
        MessageController(connection: sl());
    final NotiController notiController = NotiController();
    final account = ref.watch(authProvider).tokenModel.login!;
    final password = AuthController.header['Authorization']!.split(' ')[1];
    // final messageProvider = ref.watch(messageController);
    messageProvider.connect('#${widget.streamModel.userLogin}', account, password);


    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              // key: GlobalKey(),
              stream: messageProvider.connection.stream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data != null) {
                  message.add(messageProvider.handleMessage(snapshot.data));
                  if(message[message.length - 1]['msg-id'] == 'msg_followersonly' || message[message.length - 1]['msg-id'] == 'msg_followersonly_zero'){
                    notiController.addStream(message[message.length - 1]['content'] ?? '');
                  }
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: message.length,
                      itemBuilder: (context, index) {
                        if (index > 0 &&
                            scrollController
                                    .position.isScrollingNotifier.value ==
                                false) {
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                        }
                        return ListTile(
                          title: Text(
                            message[index]['nick'] ?? '',
                            style: TextStyle(
                                color: Color(int.parse(
                                    '0xFF${message[index]['color'] != null ? message[index]['color'].substring(1) : '808080'}'))),
                          ),
                          subtitle: Text(
                            message[index]['content'] ?? '',
                            style: const TextStyle(color: Colors.black87),
                          ),
                        );
                      });
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          ChatInput(
            messageController: messageProvider,
            notiController: notiController,
            streamModel: widget.streamModel,
          )
        ],
      ),
    );
  }
}

class ChatInput extends ConsumerStatefulWidget {
  const ChatInput({Key? key, required this.messageController, required this.notiController, required this.streamModel}) : super(key: key);
  final MessageController messageController;
  final NotiController notiController;
  final StreamModel streamModel;

  @override
  ConsumerState<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends ConsumerState<ChatInput> {
  final txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.notiController.getStream(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          Future.delayed(
            Duration.zero, () =>
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      color: kBgColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppBar(
                            title: const Text(
                              'You need to follow this channel to chat',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            toolbarHeight: 50,
                            backgroundColor: kBgColor,
                            foregroundColor: Colors.black87,
                            leading: Icon(Icons.keyboard_arrow_down_sharp),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Only followers can chat'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ref.read(eventProvider).followChannel(widget.streamModel.userId!);
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.favorite),
                              label: Text('Follow'),
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(kPrimaryColor),
                                  foregroundColor:
                                  MaterialStateProperty.all(kBgColor)),
                            ),
                          )
                        ],
                      ),
                    );
                  })
          );

        }
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: txtController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          gapPadding: 5.0),
                      labelText: 'Enter message'),
                ),
              ),
            ),
            IconButton(
                onPressed: (){
                  widget.messageController.sendMessage(txtController.text);
                  txtController.text = '';
                },
                icon: Icon(
                  Icons.near_me,
                  color: kPrimaryColor,
                ))
          ],
        );
      }
    );
  }
}

// if(message[index]['msg-id'] != null){
//
// showModalBottomSheet(
// context: context,
// builder: (BuildContext context){
// return Container(
// height: MediaQuery.of(context).size.height/5,
// color: kBgColor,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// AppBar(
// title: Text(message[index]['content'] ?? '', style: TextStyle(fontWeight: FontWeight.bold),),
// leading: Icon(Icons.keyboard_arrow_down_sharp),
// ),
// Text(message[index]['content'] ?? ''),
// ElevatedButton.icon(
// onPressed: (){},
// icon: Icon(Icons.favorite),
// label: Text('Follow'),
// style: ButtonStyle(
// backgroundColor: MaterialStateProperty.all(kPrimaryColor),
// foregroundColor: MaterialStateProperty.all(kBgColor)
// ),
// )
// ],
// ),
// );
// }
// );
// }
