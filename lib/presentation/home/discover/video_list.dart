import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/domain/video_controller.dart';
import 'package:flutter_twitch_clone/presentation/components/stream_component/stream_slider.dart';
import 'package:flutter_twitch_clone/presentation/home/browse/livestream_list.dart';
import 'package:flutter_twitch_clone/presentation/home/home_screen.dart';

import '../../../domain/stream_controller.dart';
import '../../components/video_components/video_slider.dart';

class VideoList extends ConsumerWidget {
  VideoList({Key? key, required this.gameId, required this.gameName})
      : super(key: key);
  final String gameId;
  final String gameName;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(videoProvider).getVideosByGameId(gameId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            controller: scrollController,
            children: [
              const HeaderButton(title: 'OLD PROGRAM'),
              VideoSlider(data: snapshot.data as List, gameName: gameName),
              const HeaderButton(title: 'PREVIOUS STREAMING'),
              StreamSlider(data: ref.watch(liveStreamProvider).list),
              const HeaderButton(title: 'UPLOAD'),
              StreamSlider(data: ref.watch(liveStreamProvider).list),
              const HeaderButton(title: 'OUTSTANDING'),
              StreamSlider(data: ref.watch(liveStreamProvider).list),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class HeaderButton extends StatelessWidget {
  final String title;
  const HeaderButton({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {
            // navKey.currentState!.push(
            //   MaterialPageRoute(builder: (context) => const LivestreamList()),
            // );
          },
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
