
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/user_model.dart';
import 'package:flutter_twitch_clone/domain/use_case.dart';
import 'package:flutter_twitch_clone/presentation/DI.dart';

class UserController extends ChangeNotifier {
  late List<UserModel> _users;
  UseCase useCase;
  List<UserModel> get list => List.unmodifiable(_users);
  UserController({required this.useCase}){
    _users = [];
  }

  Future getDataList() async {
    final models = await useCase.callDataList();
    _users = models.cast<UserModel>();
    notifyListeners();
  }

  Future searchUser(String query) async {
    useCase.apiLink = 'https://api.twitch.tv/helix/users?login=$query';
    final models = await useCase.callDataList();
    _users = models.cast<UserModel>();
    notifyListeners();
    useCase.apiLink = 'https://api.twitch.tv/helix/users';
  }

  UserModel getUserByLogin(String user_login){
    return _users.firstWhere((element) => element.login == user_login);
  }

}

final userProvider = ChangeNotifierProvider((ref) => UserController(useCase: UseCase(repository: sl(), model: sl<UserModel>(), apiLink: 'https://api.twitch.tv/helix/users')));