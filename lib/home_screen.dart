import 'package:flutter/material.dart';
import 'package:mapplication/widgets/bottom_bar_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.orange[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BottomBarItems(
              name: "chat",
              icon: Icons.chat,
            ),
            BottomBarItems(
              name: "home",
              icon: Icons.home,
            ),
            BottomBarItems(
              name: "map",
              icon: Icons.map,
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(),
          )
        ],
      ),
    );
  }
}
