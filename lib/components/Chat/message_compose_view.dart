import 'package:flutter/material.dart';
import 'package:mapplication/consts/styling_consts.dart';
import 'package:mapplication/utils/chatPageViewModel/chat_page_view_model.dart';
import 'package:mapplication/utils/viewModel/view_model_property_widget_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageComposeView extends StatefulWidget {
  const MessageComposeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageComposeViewState();
}

class _MessageComposeViewState extends State<MessageComposeView> {

  // Properties start

  late String _username = "Quest";
  String get username => _username;
  final TextEditingController _messageTextController = TextEditingController();

  // Methods start

  @override
  void initState() {
    fetchUsername();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _messageTextController.dispose();
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
            return SizedBox(
              height: 45,
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: appDefaultPadding 
                        ),
                        decoration: BoxDecoration(
                          color: appDefaultColor.withOpacity(0.20), 
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: appDefaultPadding / 2),
                            Expanded(
                              child: TextField(
                                controller: _messageTextController,
                                decoration: const InputDecoration(
                                  hintText: 'Type here..',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.send_rounded),
                              color: Colors.white,
                              onPressed: () {
                                vm.sendChatMessage(_messageTextController.text, vm.room, _username);
                                _messageTextController.clear();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        )
      ]
    );
  }

  void fetchUsername() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _username = sharedPreferences.getString("username")!;
  }
}

