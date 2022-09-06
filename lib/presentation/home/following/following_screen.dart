
import 'package:flutter/material.dart';
import 'package:flutter_twitch_clone/presentation/home/following/stream_list.dart';
import '../../components/content_with_title.dart';
import '../../components/layout.dart';




class FollowingScreen extends StatelessWidget {
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const LayoutScreen(
        title: 'Following',
        child: ContentWithTitle(
          title: Text('Suggest for you', style: TextStyle(color: Colors.black, fontSize: 20),),
          child: StreamList(),
        ),
      ),
    );
  }
}





