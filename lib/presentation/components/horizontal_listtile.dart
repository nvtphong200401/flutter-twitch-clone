import 'package:flutter/material.dart';
import 'package:flutter_twitch_clone/presentation/components/video_tag.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
      this.image,
      this.title,
      this.subTitle1,
      this.subTitle2,
      this.tags})
      : super(key: key);

  final Widget? image;
  final String? title, subTitle1, subTitle2;
  final List? tags;

  @override
  Widget build(BuildContext context) {
    //final converted_viewers = viewer >= 1000 ? '${(viewer / 1000).toStringAsFixed(1)}N' : viewer.toString();
    return ListTile(
      leading: image,
      title: title != null ? Text(title!) : null,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          subTitle1 != null
              ? Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2),
                  child: Text(
                    subTitle1!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              : const SizedBox(),
          subTitle2 != null
              ? Text(
                  subTitle2!,
                )
              : const SizedBox(),
          tags != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: VideoTag(
                      tags: tags!
                          .sublist(0, 3 > tags!.length ? tags!.length : 3)),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
