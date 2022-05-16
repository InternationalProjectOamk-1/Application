import 'dart:convert';
import 'package:mapplication/data/interest_data.dart';
import 'package:mapplication/models/interest_model.dart';
import 'package:http/http.dart' as http;

Future<List<InterestData>> fetchAllInterests() async {
  final response =
      await http.get(Uri.parse('http://office.pepr.com:25252/Interests'));
  if (response.body != '[]' && response.statusCode == 200) {
    List interestResponse = json.decode(response.body);
    print('Request succesful: Interests');
    print(response.statusCode);
    print(response.body);
    return interestResponse.map((e) => InterestData.fromJson(e)).toList();
  } else {
    List interestResponseLocal = interest_data;
    print('Request unsuccessful: Interests');
    print(response.statusCode);
    return interestResponseLocal.map((e) => InterestData.fromJson(e)).toList();
  }
}
