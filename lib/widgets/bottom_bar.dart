import 'package:flutter/material.dart';
import 'package:mapplication/components/bottom_bar_item.dart';
import 'package:mapplication/styles/home_style.dart';

class BottomBar extends StatelessWidget {
  final PageController controller;
  const BottomBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: myOrangeCustom,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BottomBarItems(
              name: "chat",
              icon: Icons.chat,
              press: () => {
                if (controller.hasClients)
                  {
                    controller.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                    )
                  }
              },
            ),
            BottomBarItems(
              name: "home",
              icon: Icons.home,
              press: () => {
                if (controller.hasClients)
                  {
                    controller.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                    )
                  }
              },
            ),
            BottomBarItems(
              name: "map",
              icon: Icons.map,
              press: () => {
                if (controller.hasClients)
                  {
                    controller.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                    )
                  }
              },
            ),
          ],
        ),
      ),
    );
  }
}
