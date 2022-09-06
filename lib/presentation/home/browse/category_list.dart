import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/domain/game_controller.dart';
import 'package:flutter_twitch_clone/presentation/home/discover/detail_category.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cates = ref.watch(gameProvider);
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: cates.games.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return DetailCategoryScreen(gameModel: cates.games[index]);
                        }));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              cates.games[index].boxArtUrl!
                                  .replaceAll('{width}', '58')
                                  .replaceAll('{height}', '90'),
                              loadingBuilder: (BuildContext context,
                                  Widget child, loadingProcess) {
                                if (loadingProcess == null) return child;
                                return const SizedBox(
                                  width: 100,
                                  height: 200,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              cates.games[index].name!,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ));
                })),
      ],
    );
  }
}
