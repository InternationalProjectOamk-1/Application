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

  const EventData({
    required this.id,
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
    required this.hasStarted,
  });

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

Future<List<EventData>> fetchAllEvents() async {
  final response = await http
      .get(Uri.parse('http://office.pepr.com:25252/Event/getAllEvents'));
  if (response.body != '[]' && response.statusCode == 200) {
    List eventResponse = json.decode(response.body);
    print('Request succesful: Events');
    print(response.statusCode);
    return eventResponse.map((e) => EventData.fromJson(e)).toList();
  } else {
    List eventResponseLocal = event_data;
    print('Request unsuccesful: Events');
    print(response.statusCode);
    return eventResponseLocal.map((e) => EventData.fromJson(e)).toList();
  }
}

Future<EventData> updateEvent(EventData updatedEvent) async {
  final response = await http.post(
      Uri.parse('http://office.pepr.com:25252/Event/UpdateEvent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedEvent));
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
