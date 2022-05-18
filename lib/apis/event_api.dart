import 'dart:convert';
import 'package:mapplication/consts/service_consts.dart';
import 'package:mapplication/data/event_data.dart';
import 'package:mapplication/models/event_model.dart';
import 'package:http/http.dart' as http;

Future<List<EventData>> fetchAllEvents() async {
  final response = await http.get(Uri.parse(GET_ALL_EVENTS));
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

updateEvent(EventData updatedEvent) async {
  final response = await http.post(Uri.parse(UPDATE_EVENT),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedEvent));
}

Future<EventData> createEvent(EventData event) async {
  final response = await http.post(Uri.parse(CREATE_EVENT),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(event));
  print(json.encode(response.body));
  if (response.statusCode == 200) {
    print('result: ' + response.body);
    return EventData.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    print('resultti: no can do' + response.body);
    throw Exception('Failed to create event.');
  }
}

Future joinEvent(int eventID, String userToken) async {
  await http.post(
    Uri.parse(ATTEND_EVENT + eventID.toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': userToken.replaceAll('"', ''),
    },
  );
}