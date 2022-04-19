import 'package:flutter/material.dart';
import 'package:mapplication/classes/Chat/Chat.dart';
import 'package:mapplication/classes/Chat/ChatMessage.dart';
import 'package:mapplication/components/Chat/chat_input_field.dart';
import 'package:mapplication/components/Chat/message.dart';
import 'package:mapplication/components/Chat/text_chat.dart';
import 'package:mapplication/consts/styling_consts.dart';

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({
      Key? key, required this.chat
  }) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: appDefaultPadding),
            child: ListView.builder(
              itemCount: demoChatMessages.length,
              itemBuilder: (context, index) => Message(message: demoChatMessages[index], chat: chat,),
            ),
          ), 
        ),
        const ChatInputField()
      ],
      
    );
  }
}

