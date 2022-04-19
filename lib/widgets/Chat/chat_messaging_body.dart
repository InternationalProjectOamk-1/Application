import 'package:flutter/material.dart';
import 'package:mapplication/consts/styling_consts.dart';

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Container(
          height: 50,
          decoration:  BoxDecoration(
            color: Colors.white.withOpacity(0.6),
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
        )
      ],
      
    );
  }
}