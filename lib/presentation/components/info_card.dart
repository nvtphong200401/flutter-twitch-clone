import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitch_clone/domain/auth_controller.dart';
import 'package:flutter_twitch_clone/presentation/DI.dart';
import 'package:flutter_twitch_clone/presentation/auth_screen/splash_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/constant.dart';

class InfoCard extends ConsumerWidget {
  const InfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authProvider);
    String myInfo = authController.tokenModel.login!;
    return Card(
      child: ListTile(
          textColor: Colors.black,
          style: ListTileStyle.drawer,
          leading: const FaIcon(FontAwesomeIcons.circleUser),
          title: Row(
            children: [
              Text(myInfo),
              const Spacer(),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  onPressed: () async {
                    print('token: ${AuthController.header['Authorization']}');
                    await authController.logout();
                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => SplashScreen()));
                  },
                  child: const Text('Log out'))
            ],
          )),
    );
    return Card(
      child: ListTile(
        textColor: Colors.black,
        style: ListTileStyle.drawer,
        leading: const Icon(Icons.person_off_rounded),
        title: const Text(
          'Anonymous User',
        ),
        subtitle: Wrap(children: [
          const Text(
            'Login to chat, view followed streams, and more',
          ),
          ElevatedButton.icon(
              onPressed: () => {},
              icon: const Icon(Icons.login),
              label: const Text('Log in'))
        ]),
      ),
    );
  }
}

class AvatarIcon extends StatelessWidget {
  const AvatarIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: const Icon(Icons.person_pin));
  }
}
