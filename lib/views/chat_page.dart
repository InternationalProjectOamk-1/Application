import 'package:mapplication/components/Chat/message_compose_view.dart';
import 'package:mapplication/components/Chat/room_change_view.dart';
import 'package:mapplication/consts/styling_consts.dart';
import 'package:mapplication/utils/chatPageViewModel/chat_page_view_model.dart';
import 'package:mapplication/utils/viewModel/view_model_property_widget_builder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ChatPage extends StatelessWidget {
   ChatPage(this.name,{Key? key}) : super(key: key);

  // Properties
  String? name;
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
                  child: MessageChatView(name),
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
  MessageChatView(this.name,{Key? key}) : super(key: key);

  // Properties start

  late String? name;

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
                reverse: true,
                itemCount: vm.chatMessages.length,
                itemBuilder: (BuildContext ctx, int index) =>
                  createMessageItemViewAlt(vm.chatMessages.reversed.toList()[index], context, name),
              );
            },
          )
        ),
      ],
    );
  }

  Widget createMessageItemViewAlt(ChatMessage message, BuildContext context, String? name) {
    print(name);
    return Column(
      crossAxisAlignment: message.user != name.toString()
      ? 
      CrossAxisAlignment.start
      :
      CrossAxisAlignment.end,
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: message.user != name.toString()
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
        usernameDisplay(message, name),
        const SizedBox(height: appDefaultPadding)
      ],
    );
  }

  Widget usernameDisplay(ChatMessage message, String? name) {
    if(message.user != name.toString()){
      return Text(
        message.user,
        style: const TextStyle(
          fontSize: 12
        ),
      );
    } else {
      return Text(
        name.toString(),
        style: const TextStyle(
          fontSize: 12
        ),
      );
    }
  }

  Future<String> fetchUsername() async{
    String username;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString("username")!;
    return username;
  }
}




