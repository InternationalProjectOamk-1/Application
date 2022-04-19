import 'package:flutter/material.dart';
import 'package:mapplication/consts/styling_consts.dart';
import 'package:mapplication/widgets/Chat/chat_body.dart';
import 'package:mapplication/widgets/bottom_bar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const ChatBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: appDefaultColor,
        child: const Icon(
          Icons.person_add_alt,
          color: Colors.white
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text(
        'Chat Page'
      ),
      actions: [
        IconButton(
          onPressed: (() {}),
          icon: Icon(Icons.search)
        ),
      ], 
    );
  }



}
