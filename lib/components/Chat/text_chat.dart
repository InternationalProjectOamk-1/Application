import 'package:flutter/material.dart';
import 'package:mapplication/classes/Chat/ChatMessage.dart';
import 'package:mapplication/consts/styling_consts.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key, 
    required this.message
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: appDefaultPadding,
        vertical: appDefaultPadding / 1.2,
      ),
      decoration: BoxDecoration(
        color: appDefaultColor.withOpacity(message.isSender ? 0.4 : 0.2),
        borderRadius: BorderRadius.circular(30)
      ),
      child: Text(
        message.text,
        style: const TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }
}

