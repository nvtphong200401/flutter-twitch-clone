import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/domain/game_controller.dart';
import 'package:flutter_twitch_clone/domain/stream_controller.dart';
import 'package:flutter_twitch_clone/presentation/components/header_bar.dart';

class LayoutScreen extends ConsumerWidget {
  final Widget child;
  final String title;
  const LayoutScreen({Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              HeaderBar(title: title),
            ];
          },
          body: RefreshIndicator(
              onRefresh: () async {
                await ref.read(liveStreamProvider).getDataList();
                await ref.read(gameProvider).getDataList();
              },
              child: child)),
    );
  }
}
