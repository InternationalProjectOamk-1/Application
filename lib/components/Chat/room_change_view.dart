import 'package:flutter/material.dart';
import 'package:mapplication/consts/styling_consts.dart';
import 'package:mapplication/utils/chatPageViewModel/chat_page_view_model.dart';
import 'package:mapplication/utils/viewModel/view_model_property_widget_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RoomChangeView extends StatefulWidget {
  const RoomChangeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RoomChangeViewState();
}

class RoomChangeViewState extends State<RoomChangeView> {

  // Properties start

  late String _username = "Quest";
  String get username => _username;
  final TextEditingController _roomNameController = TextEditingController();

  // Methods start

  @override
  void initState() {
    fetchUsername();
    super.initState();
  }                                                                                                      

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
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
                const SizedBox(width: appDefaultPadding * 3),
                ElevatedButton(
                  child: const Text("leave"),
                  onPressed: () => vm.leave(_username)
                ),
              ]
            );
          }
        ),
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
                    labelText: 'Enter room', hintText: 'eg. Football'
                  ),
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
                vm.join(checkRoom(_roomNameController),_username);
                vm.room = checkRoom(_roomNameController);
                Navigator.pop(context);
              }
            )
          ],
        );
      }
    );
  }

  String checkRoom(TextEditingController tec) {
    String room;
    if(tec.text == "") {
      room = "general";
    } else {
      room = tec.text;
    }
    return room;
  }

  void fetchUsername() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _username = sharedPreferences.getString("username")!;
  }
}