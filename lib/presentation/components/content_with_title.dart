import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constant.dart';

class ContentWithTitle extends ConsumerWidget {
  final Widget? title;
  final Widget child;
  const ContentWithTitle({this.title, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        AppBar(
          leading: const Text(''),
          leadingWidth: 0,
          backgroundColor: kBgColor,
          elevation: 0.0,
          title: title,
        ),
        child,
      ],
    );
  }
}
