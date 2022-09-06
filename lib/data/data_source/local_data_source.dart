import 'package:flutter_twitch_clone/data/data_source/data_source.dart';
import 'package:flutter_twitch_clone/data/models/model.dart';
import 'package:get_storage/get_storage.dart';

class LocalDataSource extends DataSource {
  final GetStorage localStorage;
  LocalDataSource({required this.localStorage});

  Future<void> cacheModels(String key, cacheModel) async {
    return await localStorage.write(key, cacheModel.toJson());
  }

  @override
  Future<Model> getData(
      Model model, String apiLink, Map<String, String> headers) {
    final jsonModel = localStorage.read(apiLink);
    if (jsonModel != null) {
      return Future.value(model.fromJson(jsonModel));
    }
    throw "Cache Error";
  }

  @override
  Future<List<Model>> getDataList(
      Model model, String apiLink, Map<String, String> headers) {
    final jsonModel = localStorage.read(apiLink);
    if (jsonModel != null) {
      final items = <Model>[];
      for (final json in jsonModel) {
        items.add(model.fromJson(json));
      }
      return Future.value(items);
    }
    throw "Cache Error";
  }

  @override
  Future<List<Model>> postDataList(
      Model model, String apiLink, Map<String, String> headers, body) {
    // TODO: implement postDataList
    throw UnimplementedError();
  }

  @override
  Future<Model> postData(Model model, String apiLink, Map<String, String> headers, body) {
    // TODO: implement postData
    throw UnimplementedError();
  }
}
