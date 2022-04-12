//import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final userPos = const LatLng(65.0135579, 25.4809041);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ActMap'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: userPos,
              zoom: 12,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: const Text('ActMap v. 0.1'),
          )
        ],
      ),
    );
  }
}
