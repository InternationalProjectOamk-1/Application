import 'package:flutter/material.dart';
import 'package:mapplication/styles/feed_style.dart';
import 'package:mapplication/views/create_event_screen.dart';

class CreateEventButton extends StatelessWidget {
  const CreateEventButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateEventScreen(),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .2,
              vertical: 10,
            ),
            decoration: myProfileCustom,
            child: const Icon(
              Icons.event,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}
