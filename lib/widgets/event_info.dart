import 'package:flutter/material.dart';
import 'package:mapplication/components/event_location_window.dart';
import 'package:mapplication/main.dart';
import 'package:mapplication/models/event_model.dart';
import 'package:mapplication/widgets/event_modify.dart';

Future<dynamic> EventInfo(
    BuildContext context, EventData event, VoidCallback refresh) {
  return showDialog(
    context: context,
    builder: (_) => SimpleDialog(
      contentPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.orange[100],
      children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => EventEdit(context, event),
            child: const Icon(Icons.settings),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            event.title,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        const Divider(),
        Text("Host: ${event.hostID}"),
        const Divider(),
        Text("Desciption: ${event.description}"),
        const Divider(),
        Text("Members: ${event.members}"),
        const Divider(),
        Text("Starts: ${event.startEvent}"),
        const Divider(),
        event.locationBased == true
            ? SmallMapScreen(event.latitude!, event.longitude!)
            : const Text("Online"),
        const Divider(),
        TextButton(
          onPressed: () async {
            print("Pressed join");
            await joinEvent(event.id, userToken);
            Navigator.pop(context);
          },
          child: const Text("Join!"),
        ),
      ],
    ),
    barrierDismissible: true,
  );
}
