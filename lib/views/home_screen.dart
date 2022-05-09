import 'package:flutter/material.dart';
import 'package:mapplication/data/events.dart';
import 'package:mapplication/styles/home_style.dart';
import 'package:mapplication/views/create_event_screen.dart';
import 'package:mapplication/views/profile_screen.dart';
import 'package:mapplication/widgets/event_builder.dart';
import 'package:mapplication/widgets/profile_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: event_data.length,
            itemBuilder: (context, index) {
              return eventBuilder(context, index);
            },
          ),
          Padding(
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
                    horizontal: size.width * .2,
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
          ),
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
      ),
    );
  }
}
