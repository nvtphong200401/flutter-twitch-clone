import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/channel_model.dart';
import 'package:flutter_twitch_clone/domain/use_case.dart';

import '../presentation/DI.dart';

class ChannelController extends ChangeNotifier {
  UseCase useCase;

  ChannelController({required this.useCase});

  Future searchChannel(String query) async {
    print(query);
    if (query.isEmpty) query = '""';
    useCase.apiLink =
        'https://api.twitch.tv/helix/search/channels?query=$query';
    final models = await useCase.callDataList();
    notifyListeners();
    print(models.length);
    return models;
  }
}

final channelProvider = ChangeNotifierProvider((ref) => ChannelController(
    useCase: UseCase(
        repository: sl(),
        model: sl<ChannelModel>(),
        apiLink: 'https://api.twitch.tv/helix/search/channels')));
