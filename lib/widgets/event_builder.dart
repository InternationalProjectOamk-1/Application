import 'package:flutter/material.dart';
import 'package:mapplication/models/event_model.dart';
import 'package:mapplication/styles/home_style.dart';
import 'package:mapplication/widgets/event_info.dart';

Padding eventBuilder(BuildContext context, EventData event) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GestureDetector(
      onTap: () => EventInfo(context, event),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: myOrangeCustom,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              event.title,
              //style: Theme.of(context).textTheme.displayMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.group),
                    Text(
                      '${event.members!.length}/${event.maxPeople}',
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.manage_accounts_sharp),
                    Text('${event.hostID}'),
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
