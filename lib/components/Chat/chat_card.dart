import 'package:flutter/material.dart';
import 'package:mapplication/classes/Chat/Chat.dart';
import 'package:mapplication/consts/styling_consts.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key, 
    required this.chat,
    required this.press
  }) : super(key: key);

  final Chat chat;
  final VoidCallback press;

  @override 
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: press,
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: appDefaultPadding, vertical: appDefaultPadding * 0.75),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(chat.image)
                ),
                if (chat.isActive) 
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 63, 255, 70),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 2
                      )
                    ),
                  )
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: appDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(           //Name 
                      chat.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Opacity(
                      opacity: 0.5,
                      child: Text(          //Last message
                        chat.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    )
                  ],
                ),
              )
            ),
            Opacity(
              opacity: 0.5,
              child: isUserActive(chat.isActive, chat.time),      //Last online
            ),
          ],
        ),
      )
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
    time,
    style: const TextStyle(
      fontSize: 12
    )
  );
}