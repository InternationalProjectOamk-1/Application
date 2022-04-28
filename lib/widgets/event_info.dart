import 'package:flutter/material.dart';
import 'package:mapplication/data/events.dart';

Future<dynamic> EventInfo(BuildContext context, int index) {
  return showDialog(
    context: context,
    builder: (_) => SimpleDialog(
      contentPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.orange[100],
      children: <Widget>[
        Text(event_data[index].toString()),
        TextButton(
          onPressed: () {},
          child: const Text("Join!"),
        ),
      ],
    ),
    barrierDismissible: true,
  );
}
