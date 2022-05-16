import 'dart:convert';
import 'package:mapplication/consts/service_consts.dart';
import 'package:mapplication/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<UserData> getUserDetails() async {
  String token = await getToken();
  http.Response response =
      await http.get(Uri.parse(BASE_PATH + GET_USER_INFO), headers: {
    "Authorization": "Bearer $token",
  });
  if (response.statusCode == 200) {
    print('Request succesful: UserData');
    print(response.statusCode);
    return UserData.fromJson(jsonDecode(response.body));
  } else {
    print('Request unsuccesful: UserData');
    print(response.statusCode);
    return UserData.empty();
  }
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token")!.replaceAll('"', '');
  return token;
}
