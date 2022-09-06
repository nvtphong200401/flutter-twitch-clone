import 'package:flutter/material.dart';

class VideoTag extends StatelessWidget {
  final List tags;
  const VideoTag({Key? key, required this.tags}) : super(key: key);

  List<Widget> buildTags() {
    final List<Widget> tagWidgets = [];
    //if(tags == null) return [SizedBox()];
    for (String tag in tags) {
      tagWidgets.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(5.0)),
        child: Text(
          tag,
          style: const TextStyle(fontSize: 13),
        ),
      ));
    }
    return tagWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 3.0,
      runSpacing: 3.0,
      children: buildTags(),
    );
  }
}
