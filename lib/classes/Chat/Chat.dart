class Chat {

  final String name, lastMessage, time, image;
  final bool isActive;

  Chat({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.image,
    required this.isActive
  });
}

List chatsData = [
  Chat(
    name: 'Example user 1',
    lastMessage: 'Last Message example 1',
    time: '3m ago',
    image: 'assets/images/profilePic2.png',
    isActive: true
  ),
  Chat(
    name: 'Example user 2',
    lastMessage: 'Last Message example 2',
    time: '23m ago',
    image: 'assets/images/profilePic2.png',
    isActive: false
  ),
  Chat(
    name: 'Example user 3',
    lastMessage: 'Last Message example 3',
    time: '30m ago',
    image: 'assets/images/profilePic2.png',
    isActive: true
  ),
  Chat(
    name: 'Example user 4',
    lastMessage: 'Last Message example 4',
    time: '2h ago',
    image: 'assets/images/profilePic2.png',
    isActive: true
  ),
  Chat(
    name: 'Example user 5',
    lastMessage: 'Last Message example 5',
    time: '1h ago',
    image: 'assets/images/profilePic2.png',
    isActive: false
  ),
  Chat(
    name: 'Example user 6',
    lastMessage: 'Last Message example 6',
    time: '7m ago',
    image: 'assets/images/profilePic2.png',
    isActive: false
  ),
  Chat(
    name: 'Example user 7',
    lastMessage: 'Last Message example 7',
    time: '3m ago',
    image: 'assets/images/profilePic2.png',
    isActive: false
  ),
  Chat(
    name: 'Example user 8',
    lastMessage: 'Last Message example 8',
    time: '32m ago',
    image: 'assets/images/profilePic2.png',
    isActive: false
  ),
  Chat(
    name: 'Example user 9',
    lastMessage: 'Last Message example 9',
    time: '13m ago',
    image: 'assets/images/profilePic2.png',
    isActive: false
  ),
  Chat(
    name: 'Example user 10',
    lastMessage: 'Last Message example 10',
    time: '12m ago',
    image: 'assets/images/profilePic2.png',
    isActive: false
  ),
  Chat(
    name: 'Example user 11',
    lastMessage: 'Last Message example 11',
    time: '20m ago',
    image: 'assets/images/profilePic2.png',
    isActive: true
  ),
  Chat(
    name: 'Example user 12',
    lastMessage: 'Last Message example 12',
    time: '45m ago',
    image: 'assets/images/profilePic2.png',
    isActive: false
  ),
];