import 'package:mapplication/components/Chat/message_compose_view.dart';
import 'package:mapplication/components/Chat/room_change_view.dart';
import 'package:mapplication/consts/styling_consts.dart';
import 'package:mapplication/utils/chatPageViewModel/chat_page_view_model.dart';
import 'package:mapplication/utils/viewModel/view_model_property_widget_builder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  // Properties

  // Methods

  @override
  Widget build(BuildContext context) {
    final vm = ChatPageViewModel();
    return ChatPageViewModelProvider(
      viewModel: vm,
      childBuilder: (ctx) {
        return Scaffold(
          appBar: AppBar(title: const Text("Interests chat")),
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children:  <Widget>[
                RoomChangeView(),
                Divider(),
                Expanded(
                  child: MessageChatView(),
                ),
                MessageComposeView(),
              ],
            ),
          )
        );
      }
    );
  }
}

class MessageChatView extends StatelessWidget {
  MessageChatView({Key? key}) : super(key: key);

  // Properties start

  late String _username = "Quest1";

  // Methods start

  @override
  Widget build(BuildContext context) {
    final vm = ChatPageViewModelProvider.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: ViewModelPropertyWidgetBuilder<ChatMessage>(
            viewModel: vm,
            propertyName: ChatPageViewModel.chatMessagesPropName,
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: vm.chatMessages.length,
                itemBuilder: (BuildContext ctx, int index) =>
                  _createMessageItemViewAlt(vm.chatMessages[index], context),
              );
            },
          )
        ),
      ],
    );
  }

  Widget _createMessageItemViewAlt(ChatMessage message, BuildContext context) {
    return Column(
      crossAxisAlignment: message.user != _username
      ? 
      CrossAxisAlignment.start
      :
      CrossAxisAlignment.end,
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: message.user != _username
          ? 
          MainAxisAlignment.start
          :
          MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: const
              EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.5,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              child: Text(
                message.message,
                style: const TextStyle(
                  color: Colors.black,
                )
              ),
            ),
          ],
        ),
        message.user != _username
        ?
        Text(
          message.user,
          style: const TextStyle(
            fontSize: 12
          ),
        )
        :
        usernameDisplay(),
        const SizedBox(height: appDefaultPadding)
      ],
    );
  }

  Widget usernameDisplay() {
    return FutureBuilder<String>(
      future: fetchUsername(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.toString());
        } else {
          return Text('awaiting the future');
        }
      },
    );
  }

  Future<String> fetchUsername() async{
    String username;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString("username")!;
    _username = username;
    return username;
  }
}




