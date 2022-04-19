import 'package:flutter/material.dart';
import 'package:mapplication/classes/Chat/Chat.dart';
import 'package:mapplication/widgets/Chat/chat_messaging_body.dart';

import '../../consts/styling_consts.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen( {
      Key? key, 
      required this.chat,
      required this.index
    }) : super(key: key);

  final Chat chat;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(chat.image),
            ),
            const SizedBox(width: appDefaultPadding * 1.25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.name,
                  style: const TextStyle(
                    fontSize: 16
                  ),
                ),
                const SizedBox(height: appDefaultPadding / 4),
                Opacity(
                  opacity: 0.75,
                  child: isUserActive(chat.isActive, chat.time)
                )
              ],
            )
          ]
        )
      ),
      body: ChatScreenBody(chat: chat),
    );
  }
}

Text isUserActive(bool isActive, String time) {
  return
  isActive 
  ? 
  const Text(
    'Active',
    style: TextStyle(
      fontSize: 12
    )
  )
  :
  Text(
    'Last active $time',
    style: const TextStyle(
      fontSize: 12
    )
  );
}