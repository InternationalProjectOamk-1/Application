import 'package:flutter/material.dart';
import 'package:mapplication/apis/event_api.dart';
import 'package:mapplication/models/event_model.dart';
import 'package:mapplication/widgets/create_event_button.dart';
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

  loadEvents() async {
    _eventsData = await fetchAllEvents();
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
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
              const CreateEventButton(),
              const ProfileButton(),
            ],
          ),
        ),
      );
    }
  }
}
