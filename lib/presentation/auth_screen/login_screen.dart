import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/core/constant.dart';
import 'package:flutter_twitch_clone/presentation/auth_screen/webview_screen.dart';

import '../../domain/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const route = '/login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authProvider);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: size.width * 2 / 3,
            ),
            SizedBox(
              height: size.height * 1 / 3,
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebviewScreen()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              ),
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
