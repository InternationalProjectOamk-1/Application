import 'package:flutter/material.dart';
import 'package:mapplication/models/event_model.dart';

TextEditingController _newTitle = TextEditingController();
TextEditingController _newDescription = TextEditingController();

Future<dynamic> EventEdit(BuildContext context, EventData event) {
  EventData newEvent = event;
  return showDialog(
    context: context,
    builder: (_) => SimpleDialog(
      contentPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.orange[100],
      children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.check),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: TextField(
            controller: _newTitle,
            style: Theme.of(context).textTheme.headline4,
            decoration: InputDecoration(hintText: event.title),
          ),
        ),
        const Divider(),
        TextField(
          controller: _newDescription,
          decoration: InputDecoration(
            hintText: "desciption: ${event.description}",
          ),
        ),
        const Divider(),
        Text("Starts: ${event.startEvent}"),
        const Divider(),
      ],
    ),
    barrierDismissible: true,
  );
}
