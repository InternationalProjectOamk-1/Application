import 'package:flutter/material.dart';
import 'package:mapplication/data/events.dart';

Padding EventBuilder(BuildContext context, int index) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text(event_data[index].toString()),
          backgroundColor: Colors.orange[100],
          actions: [TextButton(onPressed: () {}, child: const Text("Join!"))],
        ),
        barrierDismissible: true,
      ),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              event_data[index]['title'].toString(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.group),
                    Text(
                      '${event_data[index]["members"]}/${event_data[index]["maxPeople"]}',
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.manage_accounts_sharp),
                    Text('${event_data[index]["hostID"]}'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
