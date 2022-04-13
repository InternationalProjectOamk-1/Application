import 'package:flutter/material.dart';
import 'package:mapplication/components/create_event_textfield.dart';
import 'package:mapplication/data/events.dart';
import 'package:mapplication/styles/home_style.dart';

class EventButton extends StatelessWidget {
  const EventButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var _fetched_data = event_data[0];

    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (_) => SimpleDialog(
              backgroundColor: Colors.orange[100],
              contentPadding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(50)),
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    CreateEventTextField(
                      name: 'Event title',
                      icon: Icons.search,
                    ),
                    SizedBox(height: 10),
                    CreateEventTextField(
                      name: 'Place',
                      icon: Icons.map,
                    ),
                    SizedBox(height: 10),
                    CreateEventTextField(
                      name: 'Interests',
                      icon: Icons.tag,
                    ),
                    SizedBox(height: 10),
                    CreateEventTextField(
                      name: 'Number of people',
                      icon: Icons.people,
                    ),
                    SizedBox(height: 10),
                    CreateEventTextField(
                      name: 'Start of event',
                      icon: Icons.start,
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: null,
                      child: Text("Create event"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * .2),
            decoration: myProfileCustom,
            child: const Icon(
              Icons.event,
              size: 35,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}
