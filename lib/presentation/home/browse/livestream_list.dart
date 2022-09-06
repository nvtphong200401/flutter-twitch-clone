import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/stream_model.dart';
import 'package:flutter_twitch_clone/domain/stream_controller.dart';
import 'package:flutter_twitch_clone/presentation/components/stream_component/livestream_card.dart';
import 'package:flutter_twitch_clone/presentation/logic_holder/video_store.dart';

import '../../DI.dart';
import '../../detail_screen/detail_stream_screen.dart';


final indexProvider = StateProvider((ref) {
  return 0;
});

class LivestreamList extends ConsumerStatefulWidget {
  LivestreamList({
    Key? key,
    required this.data
  }) : super(key: key);
  List<StreamModel> data;
  @override
  ConsumerState createState() => _LivestreamListState();
}

class _LivestreamListState extends ConsumerState<LivestreamList> {
  final ScrollController _controller = ScrollController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.addListener(() {
      //print('offset ${_controller.offset}');
      double a =
          _controller.offset / 100 * 0.282891874053125 + 0.315299178291342;
      int index = a.round();
      if (ref.read(indexProvider) != index) {
        ref.read(indexProvider.notifier).state = index;
      }
    });
  }
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final data =
    final state = ref.watch(indexProvider);
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: widget.data.length,
      controller: _controller,

      itemBuilder: (context, index) {
        print(index);
        Widget thumbnail = Image.network(widget.data[index]
            .thumbnailUrl!
            .replaceAll('{width}', '${size.width.toInt()}')
            .replaceAll('{height}', '248'));
        // final webview = CustomWebView(videoStore: video,);
        // Widget thumbnail = SizedBox(
        //   height: 248,
        //   width: size.width,
        //   child:
        //   webview//endPoint: '&channel=${data[index].userLogin!}'),
        // );

        if (index == state) {
          final video = sl<VideoStore>();
          video.videoUrl+='&channel=${widget.data[index].userLogin!}';
          // webview.isPlay = true;
         // print(webview.videoStore != null ? "khac null" : "bang null");

          //webview.videoStore.controller!.runJavascript('document.getElementsByTagName("video")[0].play();');
          //video.handlePausePlay();
          thumbnail = SizedBox(
            height: 248,
            width: size.width,
            child:
                CustomWebView(videoStore: video, thumbnail: widget.data[index].thumbnailUrl!),
          );
        }
        return LivestreamCard(
          streamModel: widget.data[index],
          thumbnail: thumbnail,
        );
      },
    );
  }
}
