import '../data/models/model.dart';
import '../data/repository/repository.dart';
import 'auth_controller.dart';

class UseCase {
  final Repository repository;
  final Model model;
  String apiLink;
  UseCase(
      {required this.repository, required this.model, required this.apiLink});

  Future callData() async {
    return await repository.getData(model, apiLink, AuthController.header);
  }

  Future<List> callDataList() async {
    List models =
        await repository.getDataList(model, apiLink, AuthController.header);
    return models;
  }

  Future<List> postDataList(dynamic body) async {
    final header = AuthController.header;
    // header['Authorization'] = 'Bearer j5cwuao7enfq6go8ey7to6m86et9zv';
    List models = await repository.postDataList(model, apiLink, body, AuthController.header);
    return models;
  }

  Future postData(dynamic body) async {
    final header = AuthController.header;
    return await repository.postData(model, apiLink, body, {'Content-Type' : 'application/x-www-form-urlencoded'});
  }
}
