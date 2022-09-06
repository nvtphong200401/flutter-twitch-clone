import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/video_model.dart';
import 'package:flutter_twitch_clone/presentation/components/horizontal_listtile.dart';
import 'package:flutter_twitch_clone/presentation/components/skeleton.dart';

import '../../../core/helper_func.dart';
import '../../../domain/tag_controller.dart';

class VideoCard extends ConsumerWidget {
  VideoCard({
    Key? key,
    required this.thumbnail,
    required this.videoModel,
    required this.gameName
  }) : super(key: key);
  Widget thumbnail;
  VideoModel videoModel;
  String gameName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            children: [
              thumbnail,
              Positioned(
                top: 5,
                left: 10,
                child: Container(
                  padding: EdgeInsets.all(3),
                  child: Text(videoModel.duration!, style: TextStyle(color: Colors.white),),
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(5)
                  ),
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    child: Text('${convertViewer(videoModel.viewCount!)} Viewers', style: TextStyle(color: Colors.white),),
                    decoration: BoxDecoration(
                        color: Colors.black54.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),
                  )
              )
            ],
          ),
          FutureBuilder(
              future: ref.watch(tagProvider).getStreamTags(videoModel.userId!),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: ListTileSkeleton(),);
                }
                return CustomListTile(title: videoModel.userName, subTitle1: videoModel.title, subTitle2: gameName, tags: snapshot.data as List,);
              }
          )
        ],
      ),
    );
  }
}
