import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/core/constant.dart';
import 'package:flutter_twitch_clone/data/models/stream_model.dart';
import 'package:flutter_twitch_clone/presentation/components/horizontal_listtile.dart';
import 'package:flutter_twitch_clone/presentation/home/home_screen.dart';
import 'package:flutter_twitch_clone/presentation/logic_holder/video_store.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/custom_pipview/pip_view.dart';
import '../../domain/event_controller.dart';
import '../../domain/message_controller.dart';
import '../DI.dart';
import '../components/chat_box.dart';

class DetailStreamScreen extends ConsumerStatefulWidget {
  final StreamModel streamModel;

  DetailStreamScreen({Key? key, required this.streamModel}) : super(key: key);

  @override
  ConsumerState createState() => _DetailStreamScreenState();
}

class _DetailStreamScreenState extends ConsumerState<DetailStreamScreen>
    with AutomaticKeepAliveClientMixin<DetailStreamScreen> {
  final messageProvider =
      ChangeNotifierProvider((ref) => MessageController(connection: sl()));
  late final chatBox = ChatBox(streamModel: widget.streamModel);

  @override
  Widget build(BuildContext context) {
    final streamModel = widget.streamModel;

    return Material(
      child: SafeArea(
        child: PIPView(builder: (BuildContext context, bool isFloating) {
          final video = sl<VideoStore>();
          return Scaffold(
              resizeToAvoidBottomInset: !isFloating,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: kPrimaryColor,
                elevation: 0,
                leading: IconButton(
                  color: kPrimaryColor,
                  onPressed: () {
                    PIPView.of(context)!.presentBelow(HomeScreen());
                    // context.router.pop();
                    // context.router.push(PIPRouter(child: this.widget));
                    // context.router.push(HomeRouter());
                  },
                  icon: Icon(Icons.keyboard_arrow_down_sharp),
                ),
              ),
              extendBodyBehindAppBar: true,
              body: OrientationBuilder(builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomWebView(
                            videoStore: video
                              ..videoUrl +=
                                  '&channel=' + streamModel.userLogin!,
                            thumbnail: streamModel.thumbnailUrl!,
                            //endPoint: '&channel=' + streamModel.userLogin!,
                          ),
                        ),
                        isFloating
                            ? SizedBox()
                            : Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        CustomListTile(
                                          title: streamModel.userLogin,
                                          subTitle1: streamModel.title,
                                          subTitle2: streamModel.gameName,
                                        ),
                                        Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: ElevatedButton.icon(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  kPrimaryColor),
                                                      foregroundColor:
                                                          MaterialStateProperty
                                                              .all(kBgColor)),
                                                  onPressed: () {
                                                    ref
                                                        .read(eventProvider)
                                                        .followChannel(
                                                            streamModel
                                                                .userId!);
                                                  },
                                                  icon: Icon(Icons
                                                      .favorite_border_outlined),
                                                  label: Text('Follow')),
                                            )),
                                      ],
                                    ),
                                    chatBox
                                  ],
                                ),
                              ),
                      ]);
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      // height: size.height,
                      child: CustomWebView(
                        videoStore: video
                          ..videoUrl += '&channel=' + streamModel.userLogin!,
                        thumbnail: streamModel.thumbnailUrl!,
                        //endPoint: '&channel=' + streamModel.userLogin!,
                      ),
                    ),
                    isFloating ? SizedBox() : chatBox
                  ],
                );
              }));
        }),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false; //
}

class CustomWebView extends StatefulWidget {
  CustomWebView(
      {Key? key,
      //required this.endPoint,
      required this.videoStore,
      required this.thumbnail})
      : super(key: key) {
    WebView.platform = SurfaceAndroidWebView();
  }

  //final String endPoint;
  final VideoStore videoStore;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final String thumbnail;

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  int _stackToView = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double start = 0;
    double end = 0;
    return IndexedStack(index: _stackToView, children: [
      Stack(
        children: [
          WebView(
            debuggingEnabled: true,
            gestureRecognizers: Set()
              ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()
                ..onTap = () {
                  widget.videoStore.handlePausePlay();
                })),
            initialUrl: widget.videoStore.videoUrl, //+ endPoint,
            javascriptMode: JavascriptMode.unrestricted,
            allowsInlineMediaPlayback: true,
            initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
            onWebViewCreated: (WebViewController webViewController) {
              widget.videoStore.controller = webViewController;
              // videoStore.controller!.runJavascript('document.getElementsByTagName("video")[0].play();');
              // if(isPlay){
              //   print("playing bitch");
              // }
              //rootBundle.loadString(key)
              // _webViewController = webViewController;
              // loadHtml();
              //webViewController.loadUrl(Uri.dataFromString('<meta name="viewport" content="width=device-width,initial-scale=1" /><body margin="0" padding="0" style="margin: 0 0 0 0;"><iframe height="720" width="1280" allowfullscreen frameborder="0" margin="0" padding="0" preload="none" src="https://clips.twitch.tv/embed?allowfullscreen=false&muted=false&clip=ObliviousObservantDunlinRalpherZ&parent=localhost&autoplay=true" scrolling="no"></iframe></body>', mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
              widget._controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onPageFinished: (string) {
              setState(() {
                _stackToView = 0;
              });
              widget.videoStore.initVideo();
            },
            javascriptChannels: widget.videoStore.javascriptChannels,
            gestureNavigationEnabled: true,
            backgroundColor: const Color(0x00000000),
          ),
          GestureDetector(
              onTap: () {
                widget.videoStore.handlePausePlay();
              },
              onPanDown: (pan){
                start = pan.globalPosition.dy;
              },
              onPanUpdate: (pan){
                end = pan.globalPosition.dy;
                if(end - start > 30){
                  PIPView.of(context)!.presentBelow(HomeScreen());
                }
                else {
                  widget.videoStore.handlePausePlay();
                }
              },
              child: Container(
                width: size.width,
                height: 248,
                color: Colors.transparent,
              ))
        ],
      ),
      Image.network(widget.thumbnail
          .replaceAll('{width}', '${size.width.toInt()}')
          .replaceAll('{height}', '248'))
    ]);
  }
}
