import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapplication/data/interests.dart';

class InterestData {
  final int id;
  final String name;
  final String description;

  const InterestData(
      {required this.id, required this.name, required this.description});

  factory InterestData.fromJson(Map<String, dynamic> json) {
    return InterestData(
        id: json['id'], name: json['name'], description: json['description']);
  }
}
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
      return interestResponseLocal
          .map((e) => InterestData.fromJson(e))
          .toList();
    }
  }

