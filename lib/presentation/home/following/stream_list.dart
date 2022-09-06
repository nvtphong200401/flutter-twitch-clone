
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/domain/stream_controller.dart';
import 'package:flutter_twitch_clone/domain/tag_controller.dart';
import 'package:flutter_twitch_clone/domain/video_controller.dart';
import 'package:flutter_twitch_clone/presentation/animation/animation.dart';
import 'package:flutter_twitch_clone/presentation/components/chat_box.dart';
import 'package:flutter_twitch_clone/presentation/components/horizontal_listtile.dart';
import 'package:flutter_twitch_clone/presentation/components/skeleton.dart';
import 'package:flutter_twitch_clone/presentation/detail_screen/detail_stream_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/helper_func.dart';

class StreamList extends ConsumerWidget {
  const StreamList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final videoController = ref.watch(videoProvider);
    final livestream = ref.watch(liveStreamProvider);
    final data = livestream.list;
    return Expanded(
      child: ListView.builder(
        reverse: false,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // context.pushRoute(DetailStreamRoute(streamModel: data[index]));
                Navigator.of(context, rootNavigator: true).push(NavigateRightToLeftAnimation(child: DetailStreamScreen(streamModel: data[index]))) ;
                // Navigator.of(context, rootNavigator: true).push(
                //     MaterialPageRoute(
                //         builder: (_) => DetailStreamScreen(
                //           streamId: 1,
                //             streamModel: data[index])));
              },
              child: CustomListTile(
                  image: Stack(children: [
                    Image.network(data[index]
                        .thumbnailUrl!
                        .replaceAll('{width}', '440')
                        .replaceAll('{height}', '248')),
                    Positioned(
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 14,
                          ),
                          Text(
                            convertViewer(data[index].viewerCount!),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      bottom: 3,
                      left: 3,
                    )
                  ]),
                  title: data[index].userName!,
                  subTitle1: data[index].title!,
                  subTitle2: data[index].gameName!,
                  tags: data[index].tagIds
                  // FutureBuilder(
                  //     future:
                  //         ref.watch(tagProvider).getStreamTags(data[index].userId!),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.waiting) {
                  //         return ListTileSkeleton();
                  //       }
                  //       return CustomListTile(
                  //         image: Stack(children: [
                  //           Image.network(data[index]
                  //               .thumbnailUrl!
                  //               .replaceAll('{width}', '440')
                  //               .replaceAll('{height}', '248')),
                  //           Positioned(
                  //             child: Row(
                  //               children: [
                  //                 Icon(
                  //                   Icons.circle,
                  //                   color: Colors.red,
                  //                   size: 14,
                  //                 ),
                  //                 Text(
                  //                   convertViewer(data[index].viewerCount!),
                  //                   style: TextStyle(
                  //                       color: Colors.white,
                  //                       fontWeight: FontWeight.bold),
                  //                 )
                  //               ],
                  //             ),
                  //             bottom: 3,
                  //             left: 3,
                  //           )
                  //         ]),
                  //         title: data[index].userName!,
                  //         subTitle1: data[index].title!,
                  //         subTitle2: data[index].gameName!,
                  //         tags:
                  //             snapshot.data != null ? snapshot.data as List : null,
                  //       );
                  //     }),
                  ),
            ),
          );
        },
      ),
    );
  }
}
