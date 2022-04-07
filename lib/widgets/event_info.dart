import 'package:flutter/material.dart';
import 'package:mapplication/data/events.dart';

Future<dynamic> EventInfo(BuildContext context, int index) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: Text(event_data[index].toString()),
      backgroundColor: Colors.orange[100],
      actions: [TextButton(onPressed: () {}, child: const Text("Join!"))],
    ),
    barrierDismissible: true,
  );
}
