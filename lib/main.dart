import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/presentation/DI.dart';
import 'package:flutter_twitch_clone/presentation/auth_screen/login_screen.dart';
import 'package:flutter_twitch_clone/presentation/auth_screen/splash_screen.dart';
import 'package:flutter_twitch_clone/presentation/auth_screen/webview_screen.dart';
import 'package:flutter_twitch_clone/presentation/home/home_screen.dart';
import 'package:web_socket_channel/io.dart';

import 'core/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      debug: true);
  final channel = IOWebSocketChannel.connect(Uri.parse('ws://10.0.2.2:8765'));
  channel.stream.listen((event) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Notification from twitch',
            body: 'You have a new subscription !'));
  });
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  //var scaffoldKey = GlobalKey<ScaffoldState>();

  // This widget is the root of your application.
  // final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //     routeInformationParser: _appRouter.defaultRouteParser(),
    //     routerDelegate: _appRouter.delegate()
    // );

    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
        WebviewScreen.route: (context) => WebviewScreen()
      },
      initialRoute: '/',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: kPrimaryColor,
          backgroundColor: kBgColor,
          scaffoldBackgroundColor: kBgColor,
          typography: Typography.material2021(),
          colorScheme: ColorScheme.fromSwatch(accentColor: kPrimaryColor),
          progressIndicatorTheme:
              ProgressIndicatorThemeData(color: kPrimaryColor)),
      //home: const SplashScreen(),
    );
  }
}
