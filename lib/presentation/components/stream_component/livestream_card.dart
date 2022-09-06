import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/stream_model.dart';
import 'package:flutter_twitch_clone/presentation/components/skeleton.dart';
import 'package:flutter_twitch_clone/presentation/detail_screen/detail_stream_screen.dart';

import '../../../core/helper_func.dart';
import '../../../domain/tag_controller.dart';
import '../chat_box.dart';
import '../horizontal_listtile.dart';

class LivestreamCard extends ConsumerWidget {
  const LivestreamCard({
    Key? key,
    required this.streamModel,
    required this.thumbnail,
  }) : super(key: key);
  final Widget thumbnail;
  final StreamModel streamModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        // context.pushRoute(DetailStreamRoute(streamModel: streamModel));
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => DetailStreamScreen(streamModel: streamModel,)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            children: [
              // Image.network(streamModel.thumbnailUrl!.replaceAll('{width}', '440').replaceAll('{height}', '248')),
              // SizedBox(
              //   height: 248,
              //     width: 440,
              //     child: CustomWebView(channelName: streamModel.userLogin!)
              // ),
              thumbnail,
              Positioned(
                top: 5,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    'LIVE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.black54.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      '${convertViewer(streamModel.viewerCount!)} Viewers',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ))
            ],
          ),
          CustomListTile(
            title: streamModel.userName,
            subTitle1: streamModel.title,
            subTitle2: streamModel.gameName,
            tags: streamModel.tagIds
          )
          // FutureBuilder(
          //     future: ref.watch(tagProvider).getStreamTags(streamModel.userId!),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const ListTileSkeleton();
          //       }
          //       return CustomListTile(
          //         title: streamModel.userName,
          //         subTitle1: streamModel.title,
          //         subTitle2: streamModel.gameName,
          //         tags: snapshot.data as List,
          //       );
          //     })
        ],
      ),
    );
  }
}
