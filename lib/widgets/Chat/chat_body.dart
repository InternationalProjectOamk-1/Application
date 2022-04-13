import 'package:flutter/material.dart';
import 'package:mapplication/classes/Chat/Chat.dart';
import 'package:mapplication/classes/Chat/ChatMessage.dart';
import 'package:mapplication/classes/Chat/chat_card.dart';
import 'package:mapplication/components/Chat/filled_outline_button.dart';
import 'package:mapplication/consts/styling_consts.dart';

class ChatBody extends StatelessWidget {
  const ChatBody ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(appDefaultPadding, 0, appDefaultPadding, appDefaultPadding),
          color: Colors.blue,
          child: Row( 
            children:[
              FillOutlineButton(press: () {}, text: 'Recent Messages'),
              const SizedBox(width: appDefaultPadding),
              FillOutlineButton(press: () {}, text: 'Active'),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen(chat: chatsData[index], index: index)));
              }
            )
          ),
        )
      ],
    );
  }
}


