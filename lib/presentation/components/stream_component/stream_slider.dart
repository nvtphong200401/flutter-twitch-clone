import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/presentation/components/stream_component/livestream_card.dart';

class StreamSlider extends ConsumerWidget {
  final List data;
  const StreamSlider({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return CarouselSlider.builder(
      itemCount: data.length,
      options: CarouselOptions(
        height: size.width < size.height ? 350 : 380,
        initialPage: (data.length / 2).ceil(),
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
        viewportFraction: 0.9,
      ),
      itemBuilder: (context, index, pageViewIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: LivestreamCard(
            streamModel: data[index],
            thumbnail: Image.network(
              data[index]
                  .thumbnailUrl!
                  .replaceAll('{width}', '440')
                  .replaceAll('{height}', '248'),
              errorBuilder: (context, _, trace) {
                return Image.network(
                    'https://www.semtek.com.vn/wp-content/uploads/2021/01/loi-404-not-found-2.jpg');
              },
            ),
          ),
        );
      },
    );
  }
}
