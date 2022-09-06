import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/game_model.dart';
import 'package:flutter_twitch_clone/domain/use_case.dart';
import 'package:flutter_twitch_clone/presentation/DI.dart';

class GameController extends ChangeNotifier {
  UseCase useCase = UseCase(
      repository: sl(),
      model: sl<GameModel>(),
      apiLink: 'https://api.twitch.tv/helix/games/top');
  List<GameModel> games;

  List<GameModel> get list => List.unmodifiable(games);

  GameController({required this.games}) {
    getDataList();
  }

  Future getDataList() async {
    final models = await useCase.callDataList();
    games = models.cast<GameModel>();
    notifyListeners();
  }

  Future searchCategory(String query) async {
    if (query.isEmpty) query = '""';
    useCase.apiLink =
        'https://api.twitch.tv/helix/search/categories?query=$query';
    final models = await useCase.callDataList();
    useCase.apiLink = 'https://api.twitch.tv/helix/games/top';
    notifyListeners();
    return models;
  }

  List getThree() {
    return list.sublist(0, 3);
  }
}

final gameProvider = ChangeNotifierProvider(
    (ref) => GameController(games: sl<List<GameModel>>()));
