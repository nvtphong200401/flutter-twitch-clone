import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/data/models/token_model.dart';
import 'package:flutter_twitch_clone/domain/use_case.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../presentation/DI.dart';

class AuthController {
  static Map<String, String> header = {
    // 'Authorization': 'Bearer 8qr2fguxtl8n6z5wwypv7sdu85gopn',
    'Client-Id': 'pam2bsca7401eommm63ohanqzqj80q',
    'Content-Type': 'application/json'
  };
  UseCase useCase = UseCase(
      repository: sl(),
      model: sl<TokenModel>(),
      apiLink: 'https://id.twitch.tv/oauth2/validate');
  TokenModel tokenModel;

  AuthController({required this.tokenModel});

  Future cache(String token) async {
    print(token);
    header['Authorization'] = 'Bearer $token';
    await sl<GetStorage>().write('Authorization', 'Bearer $token');
  }

  Future<bool> validateToken({String? token}) async {
    if (token != null) {
      header['Authorization'] = 'Bearer $token';
      cache(token);
    } else {
      header['Authorization'] = sl<GetStorage>().read('Authorization') ??
          header['Authorization'] ??
          '';
    }
    tokenModel = await useCase.callData();
    print('token model: ${tokenModel.toJson()}');
    if (tokenModel.status != 200) return false;
    return true;
  }

  Future logout() async {
    useCase.apiLink = 'https://id.twitch.tv/oauth2/revoke';
    await useCase.postData('client_id=${header['Client-Id']}&token=${header['Authorization']}');
    await sl<GetStorage>().write('Authorization', '');
    await sl<GetStorage>().remove('Authorization');
    await sl<GetStorage>().erase();
    header['Authorization'] = '';
    useCase.apiLink = 'https://id.twitch.tv/oauth2/validate';
    await CookieManager().clearCookies();
  }
}

final authProvider = Provider((ref) => AuthController(tokenModel: sl()));
