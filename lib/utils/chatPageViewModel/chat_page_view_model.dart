import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mapplication/consts/service_consts.dart' as consts;
import 'package:signalr_netcore/signalr_client.dart';
import 'package:mapplication/utils/viewModel/view_model.dart';
import 'package:mapplication/utils/viewModel/view_model_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

typedef HubConnectionProvider = Future<HubConnection> Function();

class ChatMessage {
  // Properites
  final String user;
  final String message;

  // Methods
  ChatMessage(this.user, this.message);
}

class ChatPageViewModel extends ViewModel {
  // Properties
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

  // Methods
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
        /*
        logger: logger,
        logMessageContent: true
        */
      );
    if (hubState == HubConnectionState.Disconnected) {
      _hubConnection = HubConnectionBuilder()
          .withUrl(_serverUrl, options: httpConnectionOptions)
          .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000])
          //.configureLogging(logger)
          .build();
    }
      _hubConnection.onclose(({error}) => print("Connection closed"));
      
      _hubConnection.on("receiveMessage", receiveMessage);
    }

    if (_hubConnection.state != HubConnectionState.Connected) {
      await _hubConnection.start();
    }
  }

  
  // SendMessage(string user, string message, string room, bool join, bool leave)
  Future<void> sendChatMessage(String chatMessage, String room) async {
    if (chatMessage == null || chatMessage.length == 0) {
      return;
    }
    _hubConnection.invoke("SendMessage", args: <Object>["Username", chatMessage, _room, false, false]);
  }

  void join(String room) async{
     if (room == null || room.length == 0) {
      return;
    }
    _chatMessages.clear();
    notifyPropertyChanged(chatMessagesPropName);
    _hubConnection.invoke("SendMessage", args: <Object>["", "", room,  true, false]);
    
  }

  void leave() async{
    _hubConnection.invoke("SendMessage", args: <Object>["", "", "", false, true]);
    _chatMessages.clear();
    
    if(_room == "general") {
      return;
    }

    _room = "general";
    join(_room);
    notifyPropertyChanged(roomPropName);
    notifyPropertyChanged(chatMessagesPropName);
  }
  

  void receiveMessage(List<Object>? args) {
    final String senderName = args![0].toString();
    final String message = args[1].toString();
    _chatMessages.add(ChatMessage(senderName, message));
    notifyPropertyChanged(chatMessagesPropName);
  }

  void receiveAllMessages(_room) async{
    try {
        http.Response response = await http.get(
            Uri.parse(consts.CHAT_ALL_MESSAGES + _room),
            headers: {"Accept": "application/json"});

        if (response.statusCode == 200) {
          print('Returned with HTTP status: ${response.statusCode}');
          String responseApi = response.body.toString().replaceAll("\n", "");
          print(responseApi);
        } else {
          print('Returned with HTTP status: ${response.statusCode}');
          String responseApi = response.body.toString().replaceAll("\n", "");

          if (responseApi.isNotEmpty) {
            
          } else {
            print('No content to show');
          }
        }
      } catch (e) {
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
            .dependOnInheritedWidgetOfExactType<ChatPageViewModelProvider>())!
        .viewModel;
  }
}

