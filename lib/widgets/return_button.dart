import 'package:flutter/material.dart';
import 'package:mapplication/styles/feed_style.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: myProfileCustom,
            child: const Icon(
              Icons.keyboard_return,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}
