import '../models/model.dart';

abstract class DataSource {
  Future<Model> getData(
      Model model, String apiLink, Map<String, String> headers);
  Future<List<Model>> getDataList(
      Model model, String apiLink, Map<String, String> headers);
  Future<List<Model>> postDataList(
      Model model, String apiLink, Map<String, String> headers, dynamic body);
  Future<Model> postData(Model model, String apiLink, Map<String, String> headers, dynamic body);
}
