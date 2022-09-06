
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/core/constant.dart';
import 'package:flutter_twitch_clone/data/models/channel_model.dart';
import 'package:flutter_twitch_clone/data/models/game_model.dart';
import 'package:flutter_twitch_clone/presentation/components/custom_search.dart';
import 'package:flutter_twitch_clone/presentation/components/info_card.dart';
import 'package:flutter_twitch_clone/presentation/detail_screen/detail_channel.dart';
import 'package:flutter_twitch_clone/presentation/home/discover/detail_category.dart';

class CustomNavBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: kBgColor,
      elevation: 0.2,
      foregroundColor: Colors.black,
      leading: const AvatarIcon(),
      actions: [
        IconButton(
          icon: const Icon(Icons.videocam_sharp),
          onPressed: () => {},
        ),
        IconButton(onPressed: () => {}, icon: const Icon(Icons.inbox_outlined)),
        IconButton(onPressed: () => {}, icon: const Icon(Icons.chat)),
        IconButton(
            onPressed: () async {
              final result = await showSearch(context: context, delegate: CustomSearchDelegate(ref: ref));
            if(result is GameModel){
              // context.router.push(DetailCategoryScreen(gameModel: result));
              //context.pushRoute(DetailCategoryRoute(gameModel: result));
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailCategoryScreen(gameModel: result)));
            }
            else if (result is ChannelModel) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailChannelScreen(channelModel: result)));
            }
              },
            icon: Icon(Icons.search)
        )
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
