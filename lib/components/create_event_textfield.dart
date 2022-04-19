import 'package:flutter/material.dart';
import 'package:mapplication/styles/home_style.dart';

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
      decoration: myCreateEventCustom,
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
