import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/domain/auth_controller.dart';
import 'package:flutter_twitch_clone/presentation/auth_screen/splash_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../home/home_screen.dart';

class WebviewScreen extends ConsumerWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  static const route = '/webview';

  WebviewScreen({Key? key}) : super(key: key) {
    WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: WebView(
            initialUrl:
                'https://id.twitch.tv/oauth2/authorize?response_type=token&client_id=pam2bsca7401eommm63ohanqzqj80q&redirect_uri=https://asiatwitch.page.link/short&scope=user:read:email+user:edit+channel:manage:broadcast+moderator:read:chat_settings+channel:read:subscriptions+chat:read+chat:edit',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) async {
              // webViewController.clearCache();
              // final cookieManager = CookieManager();
              // cookieManager.clearCookies();
              _controller.complete(webViewController);
              await webViewController.clearCache();
            },
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            navigationDelegate: (NavigationRequest request) async {
              print('allowing navigation to $request');
              if (request.url
                  .startsWith(('https://asiatwitch.page.link/short'))) {
                RegExp regExp = RegExp("[=][0-9a-zA-Z]+");
                final token =
                    regExp.firstMatch(request.url)!.group(0)!.substring(1);
                await authController.cache(token);
                //context.router.replaceNamed(SplashRoute.name);

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()));
              }
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              if(url.startsWith('https://asiatwitch.page.link/short')){
                RegExp regExp = new RegExp("[=][0-9a-zA-Z]+");
                final  token = regExp.firstMatch(url)!.group(0)!.substring(1);
                 authController.cache(token);
                // context.router.replaceNamed(SplashRoute.name);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashScreen()));
                 //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
            backgroundColor: const Color(0x00000000),
          ),
        ),
      ),
    );
  }
}
