import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapplication/consts/styling_consts.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration:  BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const SizedBox(width: appDefaultPadding * 2),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: appDefaultPadding 
                ),
                decoration: BoxDecoration(
                  color: appDefaultColor.withOpacity(0.10), 
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    const SizedBox(width: appDefaultPadding / 2),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type here....',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.send_rounded)
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: appDefaultPadding * 2),
          ],
        ),
      ),
    );
  }
}