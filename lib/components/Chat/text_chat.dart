import 'package:flutter/material.dart';
import 'package:mapplication/classes/Chat/ChatMessage.dart';
import 'package:mapplication/consts/styling_consts.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key, 
    required this.chatMessage
  }) : super(key: key);

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: appDefaultPadding,
        vertical: appDefaultPadding / 1.2,
      ),
      decoration: BoxDecoration(
        color: appDefaultColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30)
      ),
      child: Text(
        chatMessage.message,
        style: const TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }
}

