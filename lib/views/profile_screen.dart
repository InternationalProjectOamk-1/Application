import 'package:flutter/material.dart';
import 'package:mapplication/widgets/profile_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ProfileButton(
            icon: Icons.keyboard_return,
            press: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
