import 'package:flutter/material.dart';
import 'package:mapplication/models/event_model.dart';

Future<dynamic> EventInfo(BuildContext context, EventData event) {
  return showDialog(
    context: context,
    builder: (_) => SimpleDialog(
      contentPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.orange[100],
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Text(
            event.title,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        const Divider(),
        Text("desciption: ${event.description}"),
        const Divider(),
        TextButton(
          onPressed: () {},
          child: const Text("Join!"),
        ),
      ],
    ),
    barrierDismissible: true,
  );
}
