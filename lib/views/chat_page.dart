import 'package:mapplication/utils/chatPageViewModel/chat_page_view_model.dart';
import 'package:mapplication/utils/viewModel/view_model_property_widget_builder.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
// Properties

// Methods

  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = ChatPageViewModel();
    return ChatPageViewModelProvider(
        viewModel: vm,
        childBuilder: (ctx) {
          return Scaffold(
              appBar: AppBar(title: const Text("Chat")),
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    MessageComposeView(),
                    const Divider(),
                    const Expanded(
                      child: MessageChatView(),
                    ),
                  ],
                ),
              ));
        });
  }
}

class MessageChatView extends StatelessWidget {
  const MessageChatView({Key? key}) : super(key: key);

  // Properites

  // Methods
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
                    _createMessageItemView(vm.chatMessages[index]));
          },
        )),
      ],
    );
  }

  Widget _createMessageItemView(ChatMessage message) {
    return Column(children: <Widget>[
      ListTile(
          leading: Text("${message.user} :"),
          title: Text(message.message)),
      const Divider(),
    ]);
  }
}

class MessageComposeView extends StatefulWidget {
  const MessageComposeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageComposeViewState();
}

class _MessageComposeViewState extends State<MessageComposeView> {
  // Properties
  final TextEditingController _messageTextController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

  // Methods

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _messageTextController.dispose();
    _roomNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ChatPageViewModelProvider.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ViewModelPropertyWidgetBuilder<String>(
            viewModel: vm,
            propertyName: ChatPageViewModel.roomPropName,
            builder: (context, snapshot) {
              
              return Row(
                children: [
                  const Text(
                    "Room :",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18 ),
                    ),
                    const SizedBox(width: 5.0),
                  ElevatedButton(
                    child: 
                    vm.room.isEmpty
                    ?
                    const Text("Select Room")
                    :
                    Text(vm.room),
                    onPressed: _handleChangeRoom,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                  ),
              ]);
            }),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _messageTextController,
                decoration: const InputDecoration(
                  labelText: 'Your message:',
                  hintText: 'eg. Hi there!'
                ),
              ),
            ),
            ElevatedButton(
              child: const Text("send"),
              onPressed: () => vm.sendChatMessage(_messageTextController.text, vm.room),
            ),
            /*
            ElevatedButton(
              child: Text("join"),
              onPressed: () => vm.join(vm.room)
            ),
            */
            ElevatedButton(
              child: const Text("leave"),
              onPressed: () => vm.leave()
            ),
          ],
        )
      ],
    );
  }

  void _handleChangeRoom() async {
    final vm = ChatPageViewModelProvider.of(context);
    await showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _roomNameController,
                    autofocus: true,
                    decoration: const InputDecoration(
                        labelText: 'Enter room', hintText: 'eg. Football'),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    vm.room = _roomNameController.text;
                    vm.receiveAllMessages(vm.room);
                    vm.join(vm.room);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}
