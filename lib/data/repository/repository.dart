
import '../../core/connection_info.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../models/model.dart';

class Repository {

  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final ConnectionInfo connectionInfo;


  Repository(this.localDataSource, this.remoteDataSource, this.connectionInfo);

  Future<Model> getData(Model model, String apiLink, Map<String, String> headers) async {
    if(await connectionInfo.isConnected){
      final remoteReviews = await remoteDataSource.getData(model, apiLink, headers);
      try{
        localDataSource.cacheModels(apiLink, model);
      }
      catch(err){
        print(err.toString());
      }
      return remoteReviews;
    }
    return localDataSource.getData(model, apiLink, headers);
  }


  Future<List<Model>> getDataList(Model model, String apiLink, Map<String, String> headers) async {
    if(await connectionInfo.isConnected){
      final remoteReviews = await remoteDataSource.getDataList(model, apiLink, headers);
      localDataSource.cacheModels(apiLink, model);
      return remoteReviews;
    }
    return localDataSource.getDataList(model, apiLink, headers);
  }

  Future<List<Model>> postDataList(Model model, String apiLink, dynamic body, Map<String, String> headers) async {
    final remoteReviews = await remoteDataSource.postDataList(model, apiLink, headers, body);
    localDataSource.cacheModels(apiLink, model);
    return remoteReviews;
  }

  Future postData(Model model, String apiLink, dynamic body, Map<String, String> headers) async {
    final data = await remoteDataSource.postData(model, apiLink, headers, body);
    localDataSource.cacheModels(apiLink, model);
    return data;
  }

}