import 'package:flutter/material.dart';

class BottomBarItems extends StatelessWidget {
  final String name;
  final IconData icon;

  const BottomBarItems({
    Key? key,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("${name} tabbed"),
      child: Icon(
        icon,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}
