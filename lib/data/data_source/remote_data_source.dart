import 'package:flutter_twitch_clone/data/data_source/data_source.dart';
import 'package:flutter_twitch_clone/data/models/model.dart';

import '../../core/api_provider.dart';

class RemoteDataSource extends DataSource {
  final ApiProvider apiProvider;

  RemoteDataSource({required this.apiProvider});

  @override
  Future<Model> getData(
      Model model, String apiLink, Map<String, String> headers) async {
    final Map<String, dynamic> jsonResponse =
        await apiProvider.get(apiLink, headers);
    Model data = model.fromJson(jsonResponse);
    return data;
  }

  @override
  Future<List<Model>> getDataList(
      Model model, String apiLink, Map<String, String> headers) async {
    final Map<String, dynamic> jsonResponse =
        await apiProvider.get(apiLink, headers);

    final items = <Model>[];
    final List listObject = jsonResponse['data'] ?? [];
    for (dynamic object in listObject) {
      items.add(model.fromJson(object));
    }
    return items;
  }

  @override
  Future<List<Model>> postDataList(
      Model model, String apiLink, Map<String, String> headers, body) async {
    final Map<String, dynamic> jsonResponse =
        await apiProvider.post(apiLink, body, headers);

    final items = <Model>[];
    final List listObject = jsonResponse['data'] ?? [];
    for (dynamic object in listObject) {
      items.add(model.fromJson(object));
    }
    return items;
  }

  @override
  Future<Model> postData(Model model, String apiLink, Map<String, String> headers, body) async {
    final Map<String, dynamic> jsonResponse =
        await apiProvider.post(apiLink, body, headers);
    Model data = model.fromJson(jsonResponse);
    return data;
  }
}
