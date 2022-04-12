//import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> events = [];
  final userPos = const LatLng(65.0135579, 25.4809041);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            zoomControlsEnabled: false,
            rotateGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: userPos,
              zoom: 12,
            ),
            markers: Set.from(events),
            onLongPress: _handleLongPress,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.fromLTRB(70, 0, 0, 8),
            child: const Text('ActMap v. 0.1'),
          )
        ],
      ),
    );
  }

  _handleLongPress(LatLng pos) {
    setState(() {
      events = [];
      events.add(Marker(
        markerId: MarkerId(pos.toString()),
        position: pos,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(
          title: 'My event',
          snippet: 'Event taking place',
        ),
      ));
    });
  }
}
