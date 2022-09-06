import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/channel_model.dart';
import 'package:flutter_twitch_clone/domain/channel_controller.dart';
import 'package:flutter_twitch_clone/domain/game_controller.dart';
import 'package:flutter_twitch_clone/presentation/components/skeleton.dart';

class CustomSearchDelegate extends SearchDelegate {
  WidgetRef ref;
  CustomSearchDelegate({required this.ref});
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Future searchQuery(String query) async {
    List matchQuery = [];
    final channels = await ref.read(channelProvider).searchChannel(query);
    matchQuery += channels;
    final cates = await ref.read(gameProvider).searchCategory(query);
    matchQuery += cates;
    matchQuery.shuffle();
    return matchQuery;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return FutureBuilder(
        future: searchQuery(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final matchQuery =
                snapshot.data == null ? [] : snapshot.data as List;
            return Scrollbar(
              child: ListView.builder(
                itemCount: matchQuery.length,
                itemBuilder: (BuildContext context, int index) {
                  if (matchQuery[index] is ChannelModel) {
                    return InkWell(
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.network(
                              matchQuery[index].thumbnailUrl,
                              width: 150,
                            ),
                          ),
                          Column(
                            children: [
                              Text(matchQuery[index].displayName),
                              Text(matchQuery[index].gameName),
                            ],
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context, matchQuery[index]);
                        //_navigateEdit(context, matchQuery[index]);
                      },
                    );
                  } else {
                    return ListTile(
                      leading: Image.network(matchQuery[index]
                          .boxArtUrl
                          .replaceAll('{width}', '100')
                          .replaceAll('{height}', '100')),
                      title: Text(matchQuery[index].name),
                    );
                  }
                },
              ),
            );
          }
          return const Expanded(child: ListTileSkeleton());
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: searchQuery(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final matchQuery =
                snapshot.data == null ? [] : snapshot.data as List;
            return Scrollbar(
              child: ListView.builder(
                itemCount: matchQuery.length,
                itemBuilder: (BuildContext context, int index) {
                  if (matchQuery[index] is ChannelModel) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                matchQuery[index].thumbnailUrl,
                                width: 150,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(matchQuery[index].displayName),
                                  Text(matchQuery[index].gameName),
                                ],
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context, matchQuery[index]);
                          //_navigateEdit(context, matchQuery[index]);
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Row(
                          children: [
                            SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.network(matchQuery[index]
                                    .boxArtUrl
                                    .replaceAll('{width}', '50')
                                    .replaceAll('{height}', '50'))),
                            Expanded(
                                child: Text(
                              matchQuery[index].name,
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context, matchQuery[index]);
                          //_navigateEdit(context, matchQuery[index]);
                        },
                      ),
                    );
                  }
                },
              ),
            );
          }
          return const ListTileSkeleton();
        });
  }
}
