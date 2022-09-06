
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/core/constant.dart';
import 'package:flutter_twitch_clone/data/models/game_model.dart';
import 'package:flutter_twitch_clone/domain/game_controller.dart';
import 'package:flutter_twitch_clone/domain/stream_controller.dart';
import 'package:flutter_twitch_clone/presentation/components/layout.dart';
import 'package:flutter_twitch_clone/presentation/components/main_category.dart';
import 'package:flutter_twitch_clone/presentation/components/stream_component/stream_slider.dart';
import 'package:flutter_twitch_clone/presentation/components/vertical_listtile.dart';
import 'package:flutter_twitch_clone/presentation/home/discover/detail_category.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final livestream = ref.watch(liveStreamProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: LayoutScreen(
          title: 'Discover',
          child: ListView(
            children: [
              StreamSlider(data: ref.watch(liveStreamProvider).list),
              const MainCategory(),
              StickyHeader(
                header: Container(
                  width: size.width,
                  padding: const EdgeInsets.all(8.0),
                  color: kBgColor,
                  child: const Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: 'LIVE CHANNELS ',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                      TextSpan(
                          text: 'YOU MAY LIKE',
                          style: TextStyle(fontWeight: FontWeight.w500))
                    ], style: TextStyle(color: Colors.black54, fontSize: 15)),
                  ),
                ),
                content: StreamSlider(data: ref.watch(liveStreamProvider).list),
              ),
              StickyHeader(
                  header: Container(
                    width: size.width,
                    padding: const EdgeInsets.all(8.0),
                    color: kBgColor,
                    child: const Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: 'CATEGORY ',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: kPrimaryColor)),
                        TextSpan(
                            text: 'YOU MAY LIKE',
                            style: TextStyle(fontWeight: FontWeight.w500))
                      ], style: TextStyle(color: Colors.black54, fontSize: 15)),
                    ),
                  ),
                  content: const ListCategory()),
              ...buildListSuggestion(ref, context)
            ],
          )),
    );
  }

  List<Widget> buildListSuggestion(WidgetRef ref, BuildContext context) {
    final games = ref.watch(gameProvider).getThree();
    final list = <Widget>[];
    for (GameModel game in games) {
      final listGame =
          ref.watch(liveStreamProvider).getStreamByGameName(game.name!);
      list.add(StickyHeader(
          header: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: kBgColor,
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(TextSpan(children: [
                  const TextSpan(
                      text: 'YOU MAY LIKE CHANNEL ',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: game.name!.toUpperCase(),
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]))),
          ),
          content: StreamSlider(data: listGame)));
    }
    return list;
  }
}

class ListCategory extends ConsumerWidget {
  const ListCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameController = ref.watch(gameProvider);
    final data = gameController.list;
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){

                // Navigator(
                //   key: HomeScreen.navKey,
                //   onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => DetailCategoryScreen(gameModel: data[index])),
                // );
                // HomeScreen.navKey.currentState!.push(MaterialPageRoute(builder: (_) => DetailCategoryScreen(gameId: data[index].id, gameModel: data[index])));
                // context.router.push(DetailCategoryRoute(gameId: data[index].id, gameModel: data[index]));
                // context.pushRoute(DetailCategoryRoute(gameModel: data[index]));
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailCategoryScreen(gameModel: data[index])));
              },
              child: VerticalListTile(
                imageUrl: data[index].boxArtUrl!,
                title: data[index].name!,
                subtitle: '',
              ),
            ),
          );
        },
      ),
    );
  }
}
