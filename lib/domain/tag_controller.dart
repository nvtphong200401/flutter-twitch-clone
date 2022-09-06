import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/tag_model.dart';
import 'package:flutter_twitch_clone/domain/use_case.dart';
import 'package:flutter_twitch_clone/presentation/DI.dart';

class TagController extends ChangeNotifier {
  UseCase useCase;

  late List<TagModel> _tags;
  TagController({required this.useCase}) {
    _tags = <TagModel>[];
  }

  List<TagModel> get list => List.unmodifiable(_tags);

  Future<void> getDataList() async {
    final models = await useCase.callDataList();
    _tags = models.cast<TagModel>();
    notifyListeners();
  }

  List getListTag(List tagIds) {
    final tagsName = [];
    for (String tagId in tagIds) {
      tagsName.add(_tags
          .firstWhere((element) => element.tagId == tagId)
          .localizationNames
          ?.enUs);
    }
    return tagsName;
  }

  Future<List> getStreamTags(String userId) async {
    final tagsName = [];
    useCase.apiLink =
        'https://api.twitch.tv/helix/streams/tags?broadcaster_id=$userId';
    final models = await useCase.callDataList();
    final tagModels = models.cast<TagModel>();
    for (var model in tagModels) {
      tagsName.add(model.localizationNames!.enUs);
    }
    return tagsName;
  }
}

final tagProvider = ChangeNotifierProvider((ref) => TagController(
    useCase: UseCase(
        repository: sl(),
        model: sl<TagModel>(),
        apiLink: 'https://api.twitch.tv/helix/tags/streams')));
