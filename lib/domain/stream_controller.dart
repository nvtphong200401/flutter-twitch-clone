import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/stream_model.dart';
import 'package:flutter_twitch_clone/domain/tag_controller.dart';
import 'package:flutter_twitch_clone/domain/use_case.dart';
import 'package:flutter_twitch_clone/presentation/DI.dart';

import '../data/models/tag_model.dart';

class LivestreamController extends ChangeNotifier {
  UseCase useCase;

  late List<StreamModel> _listStream;
  LivestreamController({required this.useCase}) {
    _listStream = <StreamModel>[];
  }

  List<StreamModel> get list => List.unmodifiable(_listStream);

  Future<void> getDataList() async {
    final models = await useCase.callDataList();
    _listStream = models.cast<StreamModel>();
    _listStream =
        _listStream.where((element) => element.type == "live").toList();

    final tagController = TagController(
        useCase: UseCase(
            repository: sl(),
            model: sl<TagModel>(),
            apiLink: 'https://api.twitch.tv/helix/tags/streams'));

    await Future.wait(_listStream.map((e) => getTag(tagController, e.userId!, e)));

    notifyListeners();
  }

  Future getTag(TagController controller, String userId, StreamModel stream) async {
    stream.tagIds = List.from(await controller.getStreamTags(userId));
  }

  List<StreamModel> getStreamByGameName(String gameName) {
    return _listStream
        .where((element) => element.gameName == gameName)
        .toList();
  }

  List<StreamModel> getStreamByUser(String userId){
    return _listStream.where((element) => element.userId == userId).toList();
  }
}

final liveStreamProvider = ChangeNotifierProvider((ref) => LivestreamController(
    useCase: UseCase(
        repository: sl(),
        model: sl<StreamModel>(),
        apiLink: 'https://api.twitch.tv/helix/streams')));
