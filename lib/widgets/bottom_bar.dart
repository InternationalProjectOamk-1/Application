import 'package:flutter/material.dart';
import 'package:mapplication/components/bottom_bar_item.dart';
import 'package:mapplication/styles/home_style.dart';

class BottomBar extends StatelessWidget {
  final int screen;
  const BottomBar({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 80,
        decoration: myOrangeCustom,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BottomBarItems(
              name: "chat",
              icon: Icons.chat,
              press: () => {
                print("chat"),
              },
            ),
            BottomBarItems(
              name: "home",
              icon: Icons.home,
              press: () => {
                print("home"),
              },
            ),
            BottomBarItems(
              name: "map",
              icon: Icons.map,
              press: () => {
                print("map"),
              },
            ),
          ],
        ),
      ),
    );
  }
}
