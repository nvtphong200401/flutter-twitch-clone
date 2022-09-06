
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/presentation/components/video_components/video_card.dart';

class VideoSlider extends ConsumerWidget {
  final List data;
  final String gameName;
  const VideoSlider({Key? key, required this.data, required this.gameName}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CarouselSlider.builder(
      itemCount: data.length,
      options: CarouselOptions(
        height: 350,
        initialPage: (data.length/2).ceil() ,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
        viewportFraction: 0.9,
      ),
      itemBuilder: (context, index, pageViewIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: VideoCard(
            thumbnail: Image.network(data[index].thumbnailUrl!.replaceAll('{width}', '440').replaceAll('{height}', '248').replaceAll('%', ''),
              errorBuilder: (context, _, trace) {
                return Image.network('https://www.semtek.com.vn/wp-content/uploads/2021/01/loi-404-not-found-2.jpg');
              },),
            gameName: gameName,
            videoModel: data[index],
          ),
        );
      },
    );
  }
}