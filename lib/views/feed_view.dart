import 'package:flutter/material.dart';
import 'package:mapplication/apis/event_api.dart';
import 'package:mapplication/models/event_model.dart';
import 'package:mapplication/styles/feed_style.dart';
import 'package:mapplication/views/create_event_screen.dart';
import 'package:mapplication/views/profile_screen.dart';
import 'package:mapplication/widgets/event_builder.dart';
import 'package:mapplication/widgets/profile_button.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
}

List<EventData> _eventsData = [];
var _loading = true;

class _FeedViewState extends State<FeedView> {
  @override
  void initState() {
    loadEvents();
    super.initState();
  }

  refresh() {
    setState(() => _loading = true);
    loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return RefreshIndicator(
        onRefresh: () => refresh(),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView.builder(
                addAutomaticKeepAlives: false,
                itemCount: _eventsData.length,
                itemBuilder: (context, index) {
                  return eventBuilder(context, _eventsData[index], refresh);
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
    _eventsData = await fetchAllEvents();
    setState(() => _loading = false);
  }
}
