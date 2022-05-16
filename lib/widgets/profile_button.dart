import 'package:flutter/material.dart';
import 'package:mapplication/styles/feed_style.dart';

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback press;
  const ProfileButton({
    Key? key,
    required this.press,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () => press(),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: myProfileCustom,
            child: Icon(
              icon,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}
