import 'package:flutter/material.dart';
import 'package:mapplication/styles/feed_style.dart';
import 'package:mapplication/views/profile_screen.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: myProfileCustom,
            child: const Icon(
              Icons.person,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}
