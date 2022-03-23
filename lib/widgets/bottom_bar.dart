import 'package:flutter/material.dart';
import 'package:mapplication/widgets/bottom_bar_item.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.orange[100],
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
    );
  }
}
