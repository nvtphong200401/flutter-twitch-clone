
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/core/constant.dart';
import 'package:flutter_twitch_clone/data/models/game_model.dart';
import 'package:flutter_twitch_clone/data/models/stream_model.dart';
import 'package:flutter_twitch_clone/domain/stream_controller.dart';
import 'package:flutter_twitch_clone/presentation/home/browse/livestream_list.dart';
import 'package:flutter_twitch_clone/presentation/home/discover/video_list.dart';

class DetailCategoryScreen extends ConsumerWidget {
  GameModel gameModel;
  DetailCategoryScreen({Key? key, required this.gameModel}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  foregroundColor: kPrimaryColor,
                  backgroundColor: kBgColor,
                  expandedHeight: 170,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(gameModel.boxArtUrl!
                                .replaceAll('{width}', '100')
                                .replaceAll('{height}', '150')),
                          ),
                          Text(
                            gameModel.name!,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 50, bottom: 20),
                  child: TabBar(
                      labelPadding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      padding: EdgeInsets.only(top: 10),
                      labelColor: kPrimaryColor,
                      indicatorColor: kPrimaryColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Text('Livestream'),
                        Text('Video'),
                        Text('Clip'),
                      ]),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      LivestreamList(data: ref.watch(liveStreamProvider).getStreamByGameName(gameModel.name!),),
                      VideoList(
                        gameId: gameModel.id!,
                        gameName: gameModel.name!,
                      ),
                      LivestreamList(data: ref.watch(liveStreamProvider).getStreamByGameName(gameModel.name!),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
