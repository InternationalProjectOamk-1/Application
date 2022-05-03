import 'package:flutter/material.dart';
import 'package:mapplication/classes/Chat/Chat.dart';
import 'package:mapplication/classes/Chat/ChatMessage.dart';
import 'package:mapplication/components/Chat/text_chat.dart';
import 'package:mapplication/consts/styling_consts.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
    required this.chat
  }) : super(key: key);

  final ChatMessage message;
  final Chat chat;
  final bool isSender = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: appDefaultPadding),
      child: Row(
        mainAxisAlignment: 
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isSender) ...[
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage(chat.image),
              ),
              const SizedBox(width: appDefaultPadding / 1.5,)
            ],
            TextMessage(chatMessage: message),
          ],
      ),
    );
  }
}

