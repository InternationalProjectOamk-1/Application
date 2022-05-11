import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapplication/data/events.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../consts/service_consts.dart';

class UserData {
  late int id;
  late String? name;
  late String? email;
  late String? registrationDate;
  late String? img;
  late List? events;
  

  UserData(
    {
      required this.id,  this.name,  this.email,
      required this.registrationDate, required this.img, required this.events
    });

  UserData.empty();

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      registrationDate: json['registrationDate'],
      img: json['img'],
      events: json['events']
    );
  }
}
    Future<UserData> getUserDetails() async {
    String token = await getToken();
    http.Response response = await http
      .get(Uri.parse(BASE_PATH + GET_USER_INFO),
      headers: {
        "Authorization": "Bearer $token",
      }
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData =
      json.decode(response.body);
      print('Request succesful: UserData');
      print(response.statusCode);
      return UserData.fromJson(jsonDecode(response.body));
    } else {
      List eventResponseLocal = event_data;
      print('Request unsuccesful: UserData');
      print(response.statusCode);
      return UserData.empty();
    }
  }

  Future<String> getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!.replaceAll('"', '');
    return token;
  }

  
