import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/video_model.dart';
import 'package:flutter_twitch_clone/domain/use_case.dart';
import 'package:flutter_twitch_clone/presentation/DI.dart';

class VideoController extends ChangeNotifier {
  late List<VideoModel> _videos;
  UseCase useCase;
  VideoController({required this.useCase}) {
    _videos = [];
  }

  List<VideoModel> get list => List.unmodifiable(_videos);

  Future getVideosByUserId(String userId) async {
    useCase.apiLink = 'https://api.twitch.tv/helix/videos?user_id=$userId';
    final models = await useCase.callDataList();

    final vList = models.cast<VideoModel>();
    _videos = vList;
    return vList;
  }

  Future getVideosByGameId(String gameId) async {
    useCase.apiLink = 'https://api.twitch.tv/helix/videos?game_id=$gameId';
    final models = await useCase.callDataList();

    final vList = models.cast<VideoModel>();
    _videos = vList;
    return vList;
  }

  Future<VideoModel> getVideo(String userId, String streamId) async {
    List<VideoModel> vs = await getVideosByUserId(userId);

    return vs.firstWhere((element) => element.streamId == streamId);
  }
}

final videoProvider = ChangeNotifierProvider((ref) => VideoController(
    useCase: UseCase(
        repository: sl(),
        model: sl<VideoModel>(),
        apiLink: 'https://api.twitch.tv/helix/videos')));
