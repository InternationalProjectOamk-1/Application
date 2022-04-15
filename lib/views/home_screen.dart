import 'package:flutter/material.dart';
import 'package:mapplication/data/events.dart';
import 'package:mapplication/views/profile_screen.dart';
import 'package:mapplication/widgets/create_event.dart';
import 'package:mapplication/widgets/event_builder.dart';
import 'package:mapplication/widgets/profile_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        SafeArea(
          child: ListView.builder(
            itemCount: event_data.length,
            itemBuilder: (context, index) {
              return eventBuilder(context, index);
            },
          ),
        ),
        const EventButton(),
        ProfileButton(
          icon: Icons.person,
          press: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileScreen(),
            ),
          ),
        ),
      ],
    );
  }
}
