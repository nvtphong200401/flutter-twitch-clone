import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constant.dart';

class MainCategory extends StatelessWidget {
  const MainCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 20,
        childAspectRatio: 12 / 3,
        physics: const ScrollPhysics(),
        children: const [
          CategoryButton(
            text: 'Nhạc',
            icon: FaIcon(
              FontAwesomeIcons.music,
              color: Colors.white,
            ),
          ),
          CategoryButton(
            text: 'Game',
            icon: FaIcon(FontAwesomeIcons.gamepad, color: Colors.white),
          ),
          CategoryButton(
            text: 'Esports',
            icon: FaIcon(FontAwesomeIcons.trophy, color: Colors.white),
          ),
          CategoryButton(
            text: 'Người thực vật',
            icon: FaIcon(FontAwesomeIcons.microphone, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final Widget icon;
  const CategoryButton({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          icon
        ],
      ),
    );
  }
}
