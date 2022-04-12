import 'package:flutter/material.dart';

class BottomBarItems extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback press;

  const BottomBarItems({
    Key? key,
    required this.name,
    required this.icon,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Icon(
        icon,
        color: Colors.white,
        size: 60,
      ),
    );
  }
}
