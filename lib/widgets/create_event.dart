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
            builder: (_) => SimpleDialog(
              backgroundColor: Colors.orange[100],
              contentPadding: const EdgeInsets.all(10),
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

class CreateEventTextField extends StatefulWidget {
  final String name;
  final IconData icon;

  const CreateEventTextField({
    Key? key,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  State<CreateEventTextField> createState() => _CreateEventTextFieldState();
}

class _CreateEventTextFieldState extends State<CreateEventTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextField(
        controller: _controller,
        onSubmitted: (String value) => print(value),
        decoration: InputDecoration(
          hintText: widget.name,
          prefixIcon: Icon(widget.icon),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
