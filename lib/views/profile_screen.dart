import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mapplication/widgets/profile_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    File? image;

    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: SizedBox.square(
                        dimension: size.width * .5,
                        child:
                            image != null ? Image.file(image) : FlutterLogo(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ProfileButton(
            icon: Icons.keyboard_return,
            press: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
