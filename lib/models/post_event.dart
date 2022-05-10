import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapplication/data/events.dart';

class EventData {
  final int id;
  final String description;
  final List? interests;
  final List? members;
  final String title;
  final bool locationBased;
  final double? latitude;
  final double? longitude;
  final int hostID;
  final int maxPeople;
  final int minPeople;
  final String startEvent;
  final bool hasStarted;

  const EventData(
      {required this.id,
      required this.description,
      required this.interests,
      required this.members,
      required this.title,
      required this.locationBased,
      required this.latitude,
      required this.longitude,
      required this.hostID,
      required this.maxPeople,
      required this.minPeople,
      required this.startEvent,
      required this.hasStarted});

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['id'],
      description: json['description'],
      interests: json['interests'],
      members: json['members'],
      title: json['title'],
      locationBased: json['locationBased'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      hostID: json['hostID'],
      maxPeople: json['maxPeople'],
      minPeople: json['minPeople'],
      startEvent: json['startEvent'],
      hasStarted: json['hasStarted'],
    );
  }
}

Future<EventData> createEvent(
  String description,
  String title,
  List tagList,
  bool locationBased,
  double latitude,
  double longitude,
  int hostId,
  int maxPeople,
  int minPeople,
  String startEvent,
  bool hasStarted
) async {
final response = await http.post(
      Uri.parse('http://office.pepr.com:25252/Event/CreateEvent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "description": description,
        "interests": tagList,
        "members": [0],
        "title": title,
        "locationBased": locationBased,
        "latitude": latitude,
        "longitude": longitude,
        "hostID": hostId,
        "maxPeople": maxPeople,
        "minPeople": minPeople,
        "startEvent": startEvent,
        "hasStarted": hasStarted
      }));
  print(json.encode(response.body));
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('result: ' + jsonDecode(response.body));
    return EventData.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print('resultti: no can do' + response.body);
    throw Exception('Failed to create event.');
  }
}

