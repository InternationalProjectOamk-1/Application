import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapplication/consts/service_consts.dart' as consts;
import 'package:signalr_netcore/signalr_client.dart';
import 'package:mapplication/utils/viewModel/view_model.dart';
import 'package:mapplication/utils/viewModel/view_model_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

typedef HubConnectionProvider = Future<HubConnection> Function();

class ChatPageViewModel extends ViewModel {

  // Properties start
  
  late String _serverUrl;
  late HubConnection _hubConnection;
  HubConnectionState hubState = HubConnectionState.Disconnected;
  late Logger _logger;
  late StreamSubscription<LogRecord> _logMessagesSub;
  
  late List<ChatMessage> _chatMessages;
  static const String chatMessagesPropName = "chatMessages";
  List<ChatMessage> get chatMessages => _chatMessages;
  set chatMessages(List empty) {
    updateValue(chatMessagesPropName, _chatMessages, [], (v) => _chatMessages = []);
  }

  late String _room;
  static const String roomPropName = "room";
  String get room => _room;
  set room(String value) {
    updateValue(roomPropName, _room, value, (v) => _room = value);
  }

  late String _username;
  static const String usernamePropName = "username";
  String get username => _username;
  set setUsername(String value) {
    updateValue(usernamePropName, _username, value, (v) => _username = value);
  }

  // Methods start

  ChatPageViewModel() {
    
    _serverUrl = consts.CHAT;
    _chatMessages = [];
    _room = "general";
    _hubConnection = HubConnectionBuilder()
      .withUrl(_serverUrl)
      .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000])
      .build();
    
    Logger.root.level = Level.ALL;
    _logMessagesSub = Logger.root.onRecord.listen(_handleLogMessage);
    _logger = Logger("ChatPageViewModel");
    
    openChatConnection();
  }

  @override
  void dispose() {
    _logMessagesSub.cancel();
    super.dispose();
  }

  void _handleLogMessage(LogRecord msg) {
    print(msg.message);
  }

  Future<void> openChatConnection() async {
    final logger = _logger;

    if (hubState == HubConnectionState.Disconnected) {
      final httpConnectionOptions = HttpConnectionOptions(
        
        logger: logger,
        logMessageContent: true
        
      );
    if (hubState == HubConnectionState.Disconnected) {
      _hubConnection = HubConnectionBuilder()
        .withUrl(_serverUrl, options: httpConnectionOptions)
        .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000])
        .configureLogging(logger)
        .build();
      }
      _hubConnection.onclose(({error}) => print("Connection closed"));
      _hubConnection.on("receiveMessage", receiveMessage);
    }

    if (_hubConnection.state != HubConnectionState.Connected) {
      await _hubConnection.start();
    }
  }

  Future<void> sendChatMessage(String chatMessage, String room, String username) async {
    if (chatMessage.isEmpty || room.isEmpty) {
      return;
    }
    _hubConnection.invoke("SendMessage", args: <Object>[username, chatMessage, _room, false, false]);
  }

  void join(String room, String username) async{
    _chatMessages.clear();
    if (room.isEmpty) {
      return;
    }
    
    receiveAllMessages(room);
    _hubConnection.invoke("SendMessage", args: <Object>[username, "", room,  true, false]);
    notifyPropertyChanged(chatMessagesPropName);
  }

  void leave(String username) async{
    _hubConnection.invoke("SendMessage", args: <Object>["", "", "", false, true]);
    
    if(_room == "general") {
      return;
    }

    _room = "general";
    join(_room, username);
    notifyPropertyChanged(roomPropName);
    notifyPropertyChanged(chatMessagesPropName);
  }
  
  void receiveMessage(List<Object>? args) {
    final String user = args![0].toString();
    final String message = args[1].toString();
     _chatMessages.add(ChatMessage.recent(user, message));
    notifyPropertyChanged(chatMessagesPropName);
  }

  void receiveAllMessages(String room) async{
    
    try {
      http.Response response = await http.get(
        Uri.parse(consts.CHAT_ALL_MESSAGES + room),
        headers: {"Accept": "application/json"}
      );
      if (response.statusCode == 200) {
        print('Returned with HTTP status: ${response.statusCode} : SUCCESS');
        List jsonData =
        json.decode(response.body) as List<dynamic>;
        print("Messages on the list : ${jsonData.length}");
        
        for(var i = 0; i < jsonData.length; i++) { 
          _chatMessages.add(ChatMessage.fromJson(jsonData[i]));
        }
        
        notifyPropertyChanged(chatMessagesPropName);
      } else {
        print('Returned with HTTP status: ${response.statusCode}');
      }
    } catch (e) {
      print("error");
      print(e.toString());
    }
  }
}

class ChatPageViewModelProvider extends ViewModelProvider<ChatPageViewModel> {
  // Properties

  // Methods
  ChatPageViewModelProvider(
      {Key? key, viewModel: ChatPageViewModel, required WidgetBuilder childBuilder})
      : super(key: key, viewModel: viewModel, childBuilder: childBuilder);

  static ChatPageViewModel of(BuildContext context) {
    return (context
      .dependOnInheritedWidgetOfExactType<ChatPageViewModelProvider>()
    )!
    .viewModel;
  }
}

class ChatMessage {

  // Properites

  late int id;
  late String message;
  late String user;
  late String chatRoom;
  late String timeStamp;
  

  // Methods

  ChatMessage(
    this.id, this.message, this.user,
    this.chatRoom, this.timeStamp
  );

  ChatMessage.recent(this.user, this.message);

  factory ChatMessage.fromJson(Map<String, dynamic> data) {
  // note the explicit cast to String
  // this is required if robust lint rules are enabled
  final id = data['id'];
  final message = data['message'];
  final user = data['user'];
  final chatRoom = data['chatRoom'];
  final timeStamp = data['timestamp'];
  return ChatMessage(id, message, user, chatRoom, timeStamp);
  }


}

