import 'package:flutter/material.dart';
import 'package:mapplication/models/event_model.dart';
import 'package:mapplication/styles/home_style.dart';
import 'package:mapplication/views/create_event_screen.dart';
import 'package:mapplication/views/profile_screen.dart';
import 'package:mapplication/widgets/event_builder.dart';
import 'package:mapplication/widgets/profile_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<EventData> eventsData = [];

class _HomeScreenState extends State<HomeScreen> {
  var loading = true;
  @override
  void initState() {
    loadEvents();
    super.initState();
  }

  refresh() {
    setState(() => loading = true);
    loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return RefreshIndicator(
        onRefresh: () => refresh(),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView.builder(
                addAutomaticKeepAlives: false,
                itemCount: eventsData.length,
                itemBuilder: (context, index) {
                  return eventBuilder(context, eventsData[index], refresh);
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
        ),
      );
    }
  }

  loadEvents() async {
    eventsData = await fetchAllEvents();

    setState(() => loading = false);
  }
}
