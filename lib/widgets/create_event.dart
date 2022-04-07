import 'package:flutter/material.dart';

class EventButton extends StatelessWidget {
  const EventButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  CreateEventTextField(
                    name: 'Event title',
                    icon: Icons.search,
                  ),
                  CreateEventTextField(
                    name: 'Place',
                    icon: Icons.map,
                  ),
                  CreateEventTextField(
                    name: 'Interests',
                    icon: Icons.tag,
                  ),
                  CreateEventTextField(
                    name: 'Number of people',
                    icon: Icons.people,
                  ),
                  CreateEventTextField(
                    name: 'Start of event',
                    icon: Icons.start,
                  ),
                ],
              ),
              backgroundColor: Colors.orange[100],
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text("Create event"),
                ),
              ],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.event,
              size: 60,
              color: Colors.orange[100],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateEventTextField extends StatelessWidget {
  final String name;
  final IconData icon;

  const CreateEventTextField({
    Key? key,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: name,
          prefixIcon: Icon(icon),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
