import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/channel_model.dart';
import 'package:flutter_twitch_clone/domain/stream_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constant.dart';
import '../home/browse/livestream_list.dart';

class DetailChannelScreen extends ConsumerWidget {
  const DetailChannelScreen({
    Key? key,
    required this.channelModel
  }) : super(key: key);
  final ChannelModel channelModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  foregroundColor: kPrimaryColor,
                  backgroundColor: kBgColor,
                  expandedHeight: 300,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: FlexibleSpaceBar(
                      background: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 30),
                                        child: CircleAvatar(
                                          radius: 56,
                                          backgroundColor: Colors.red,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8), // Border radius
                                            child: ClipOval(child: Image.network(channelModel.thumbnailUrl!)),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.red
                                            ),
                                            // color: Colors.red,
                                            child: Text('Live', style: TextStyle(color: kBgColor),),
                                          ),
                                      )
                                    ],
                                  )
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        channelModel.displayName!,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(Icons.check_circle, color: kPrimaryColor,)
                                    ],
                                  ),
                                  if(channelModel.isLive!)
                                    Text.rich(
                                        TextSpan(
                                            text: 'Livestreaming',
                                            style: TextStyle(color: Colors.black87)
                                        )
                                    )

                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton.icon(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(Colors.black87),
                                    backgroundColor: MaterialStateProperty.all(Colors.transparent)
                                ),
                                onPressed: (){},
                                icon: FaIcon(FontAwesomeIcons.instagram, color: kPrimaryColor,),
                                label: Text('Instagram',),
                              ),
                              TextButton.icon(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(Colors.black87),
                                    backgroundColor: MaterialStateProperty.all(Colors.transparent)
                                ),
                                onPressed: (){},
                                icon: FaIcon(FontAwesomeIcons.facebook, color: kPrimaryColor,),
                                label: Text('Facebook',),
                              ),

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                                    foregroundColor: MaterialStateProperty.all(kBgColor),
                                ),
                                onPressed: (){},
                                icon: Icon(Icons.favorite_outline),
                                label: Text('Follow')
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 50, bottom: 20),
                  child: TabBar(
                      labelPadding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      padding: EdgeInsets.only(top: 10),
                      labelColor: kPrimaryColor,
                      indicatorColor: kPrimaryColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Text('Livestream'),
                        Text('Video'),
                        Text('Clip'),
                      ]),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      LivestreamList(data: ref.watch(liveStreamProvider).getStreamByUser(channelModel.id!),),
                      LivestreamList(data: ref.watch(liveStreamProvider).getStreamByUser(channelModel.id!),),
                      LivestreamList(data: ref.watch(liveStreamProvider).getStreamByUser(channelModel.id!),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
