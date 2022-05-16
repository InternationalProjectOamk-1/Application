class UserData {
  late int id;
  late String? name;
  late String? email;
  late String? registrationDate;
  late String? img;
  late List? events;

  UserData({
    required this.id,
    this.name,
    this.email,
    required this.registrationDate,
    required this.img,
    required this.events,
  });

  UserData.empty();

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        registrationDate: json['registrationDate'],
        img: json['img'],
        events: json['events']);
  }
}
