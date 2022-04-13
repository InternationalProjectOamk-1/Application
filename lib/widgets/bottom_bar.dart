import 'package:flutter/material.dart';
import 'package:mapplication/components/bottom_bar_item.dart';
import 'package:mapplication/styles/home_style.dart';
import 'package:mapplication/views/chat_view.dart';
import 'package:mapplication/views/home_screen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
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
               Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(
                  builder: (BuildContext context) => const ChatScreen(),
                ),
                (route) => false)
              },
            ),
            BottomBarItems(
              name: "home",
              icon: Icons.home,
              press: () => {
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomeScreen(),
                  ),
                ),
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
