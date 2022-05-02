import 'package:flutter/material.dart';
import 'package:mapplication/data/events.dart';
import 'package:mapplication/styles/home_style.dart';
import 'package:mapplication/widgets/event_info.dart';

Padding eventBuilder(BuildContext context, int index) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GestureDetector(
      onTap: () => EventInfo(context, index),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: myOrangeCustom,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              event_data[index]['title'].toString(),
              //style: Theme.of(context).textTheme.displayMedium,
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
            ),
          ],
        ),
      ),
    ),
  );
}
