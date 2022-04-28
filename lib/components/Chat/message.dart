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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: appDefaultPadding),
      child: Row(
        mainAxisAlignment: 
          message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!message.isSender) ...[
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage(chat.image),
              ),
              const SizedBox(width: appDefaultPadding / 1.5,)
            ],
            TextMessage(message: message),
            if (message.isSender) MessageStatusDot(status: message.messageStatus,)
          ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  const MessageStatusDot({
      Key? key,
      required this.status,
  }) : super(key: key);

  final MessageStatus status;

  @override
  Widget build(BuildContext context) {

    Color statusColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return errorColor;
        case MessageStatus.not_viewed:
          return appDefaultColor.withOpacity(0.1);
        case MessageStatus.viewed:
          return appDefaultColor.withOpacity(0.6);
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: const EdgeInsets.only(left: appDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: statusColor(status),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.check,
        size: 10,
        ),
    );
  }
}
