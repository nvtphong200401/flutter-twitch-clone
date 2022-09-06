import 'package:flutter/material.dart';

import '../../core/constant.dart';

class HeaderBar extends StatelessWidget {
  final String title;
  const HeaderBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const Text(''),
      backgroundColor: kBgColor,
      expandedHeight: MediaQuery.of(context).size.height / 10,
      floating: true,
      pinned: false,
      elevation: 0.0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: FlexibleSpaceBar(
          background: Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
