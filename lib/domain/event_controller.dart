import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/event_model.dart';
import 'package:flutter_twitch_clone/domain/use_case.dart';

import '../presentation/DI.dart';

class EventController extends ChangeNotifier {
  late List<EventModel> _events;
  UseCase useCase;
  List<EventModel> get list => List.unmodifiable(_events);
  EventController({required this.useCase}) {
    _events = [];
  }

  Future followChannel(String channelId) async {
    final models = await useCase.postDataList(
        '{"type":"channel.follow","version":"1","condition":{"broadcaster_user_id":"$channelId"},"transport":{"method":"webhook","callback":"https://n5jmxkbviuucl395nwjy9p.hooks.webhookrelay.com","secret":"3x4b487tzvdyxf1s3uwz97vntr7a9y"}}');
    _events = models.cast<EventModel>();
    notifyListeners();
  }
}

final eventProvider = ChangeNotifierProvider((ref) => EventController(
    useCase: UseCase(
        repository: sl(),
        model: sl<EventModel>(),
        apiLink: 'https://api.twitch.tv/helix/eventsub/subscriptions')));
