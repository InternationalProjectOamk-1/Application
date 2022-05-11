import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mapplication/data/users.dart';
import 'package:mapplication/main.dart';
import 'package:mapplication/styles/home_style.dart';
import 'package:mapplication/widgets/profile_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    File? image;

    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: const Alignment(0, 0.3),
                child: Container(
                  decoration: myProfileCustom,
                  child: SizedBox(
                    width: size.width * .8,
                    height: size.height * .6,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SizedBox(height: size.height * .2),
                          const Text("Name:"),
                          Text(user_data[0]["name"].toString()),
                          const Divider(),
                          const Text("Email:"),
                          Text(user_data[0]["email"].toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.7),
                child: GestureDetector(
                  onTap: () => {},
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: myProfileCustom,
                    child: SizedBox.square(
                      dimension: size.width * .5,
                      child: image != null
                          ? Image.file(image)
                          : const FlutterLogo(),
                    ),
                  ),
                ),
              ),
              ProfileButton(
                icon: Icons.keyboard_return,
                press: () => Navigator.pop(context),
              ),
               TextButton(
                onPressed: () => deletePrefs(context),
                child: const Text(
                  'LogOut'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

deletePrefs(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', false);
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => const MyApp2()),
  (route) => false);
}
