import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/core/constant.dart';
import 'package:flutter_twitch_clone/domain/stream_controller.dart';
import 'package:flutter_twitch_clone/presentation/home/browse/category_list.dart';
import 'package:flutter_twitch_clone/presentation/home/browse/livestream_list.dart';

class BrowseScreen extends ConsumerWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kBgColor,
            elevation: 0,
            leadingWidth: 0,
            titleSpacing: 0,
            centerTitle: false,
            actions: const [
              SizedBox(
                width: 170,
              )
            ],
            title: const TabBar(
              indicatorPadding: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              labelColor: kPrimaryColor,
              unselectedLabelColor: Colors.black,
              indicatorColor: kPrimaryColor,
              labelPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Text(
                  'Category',
                ),
                Text('Livestream')
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(children: [CategoryList(), LivestreamList(data: ref.watch(liveStreamProvider).list,)]),
              ),
            ],
          ),
        ));
  }
}
