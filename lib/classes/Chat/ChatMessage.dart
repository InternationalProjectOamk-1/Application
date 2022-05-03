class ChatMessage {
  final String user;
  final String message;
  final String room;
  bool join;
  bool leave;
   

  ChatMessage({
    required this.user,
    required this.message,
    required this.room,
    this.join = false,
    this.leave = false,
  });

}

List demoChatMessages = [];