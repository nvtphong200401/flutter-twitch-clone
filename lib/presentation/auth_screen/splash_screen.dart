
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/core/constant.dart';
import 'package:flutter_twitch_clone/presentation/auth_screen/login_screen.dart';
import 'package:flutter_twitch_clone/presentation/home/home_screen.dart';

import '../../domain/auth_controller.dart';
import '../../domain/game_controller.dart';
import '../../domain/stream_controller.dart';
import '../../domain/tag_controller.dart';
import '../../domain/user_controller.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const route = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);
    return FutureBuilder(
      future: auth.validateToken(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == false) {
            return const LoginScreen();
          }
          return FutureBuilder(
              future: Future.wait(<Future>[
                ref.read(gameProvider).getDataList(),
                ref.read(userProvider).getDataList(),
                ref.read(liveStreamProvider).getDataList(),
                ref.read(tagProvider).getDataList()
              ]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Future.delayed(Duration(milliseconds: 500), () => context.router.pushNamed(HomeRoute.name));
                  return const HomeScreen();
                  // context.router.popAndPush(HomeRouter());
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                }
                return Scaffold(
                  backgroundColor: kPrimaryColor,
                  body: Center(
                      child: Image.asset(
                        'assets/splash_logo.jpg',
                        width: 100,
                      )),
                );
                
              });
        }
        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: Center(
              child: Image.asset(
            'assets/splash_logo.jpg',
            width: 100,
          )),
        );
      },
    );
  }
}
