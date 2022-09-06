import 'package:flutter_twitch_clone/data/data_source/remote_data_source.dart';
import 'package:flutter_twitch_clone/data/models/channel_model.dart';
import 'package:flutter_twitch_clone/data/models/event_model.dart';
import 'package:flutter_twitch_clone/data/models/game_model.dart';
import 'package:flutter_twitch_clone/data/models/stream_model.dart';
import 'package:flutter_twitch_clone/data/models/token_model.dart';
import 'package:flutter_twitch_clone/data/models/user_model.dart';
import 'package:flutter_twitch_clone/data/models/video_model.dart';
import 'package:flutter_twitch_clone/domain/noti_controller.dart';
import 'package:flutter_twitch_clone/presentation/logic_holder/video_store.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:web_socket_channel/io.dart';

import '../core/api_provider.dart';
import '../core/connection_info.dart';
import '../data/data_source/local_data_source.dart';
import '../data/models/tag_model.dart';
import '../data/repository/repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerLazySingleton<ApiProvider>(
    () => ApiProvider(),
  );
  sl.registerLazySingleton<ConnectionInfo>(() => ConnectionInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => GetStorage());
  await GetStorage.init();

  // Data sources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSource(apiProvider: sl()),
  );
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSource(localStorage: sl()),
  );
  // Model
  sl.registerLazySingleton(() => TokenModel());

  sl.registerLazySingleton(() => <StreamModel>[]);
  sl.registerLazySingleton(() => StreamModel());

  sl.registerLazySingleton(() => <VideoModel>[]);
  sl.registerLazySingleton(() => VideoModel());

  sl.registerLazySingleton(() => <GameModel>[]);
  sl.registerLazySingleton(() => GameModel());

  sl.registerLazySingleton(() => <UserModel>[]);
  sl.registerLazySingleton(() => UserModel());

  sl.registerLazySingleton(() => ChannelModel());

  sl.registerLazySingleton(() => TagModel());

  sl.registerLazySingleton(() => EventModel());

  sl.registerFactory(() => NotiController());

  sl.registerFactory(
      () => IOWebSocketChannel.connect('ws://irc-ws.chat.twitch.tv:80'));

  // Repository
  sl.registerLazySingleton<Repository>(
    () => Repository(sl(), sl(), sl()),
  );

  sl.registerFactory(() => VideoStore());
}
