import 'package:flutter/material.dart';

class VerticalListTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  const VerticalListTile(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(imageUrl
            .replaceAll('{width}', '150')
            .replaceAll('{height}', '200')),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          subtitle,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
