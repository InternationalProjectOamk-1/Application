//import 'package:clippy_flutter/arc.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../styles/map_style.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _events = HashSet<Marker>();
  final placeHolderPos = const LatLng(65.0135579, 25.4809041);
  late GoogleMapController _mapController;

  Position? currentPosition;
  var geoLocator = Geolocator();
  locatePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // currentPosition = position;

    //LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    // CameraPosition cameraPosition =
    //     CameraPosition(target: latLngPosition, zoom: 11);
    // _mapController
    //     .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
          tiltGesturesEnabled: false,
          zoomControlsEnabled: false,
          rotateGesturesEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: placeHolderPos,
            zoom: 12,
          ),
          markers: _events,
          onLongPress: _handleLongPress,
          onMapCreated: _onMapCreated,
        ),
        Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.fromLTRB(70, 0, 0, 8),
          child: const Text(
            'ActMap v. 0.2',
            style: const TextStyle(),
          ),
        )
      ],
    );
  }

  _handleLongPress(LatLng pos) {
    setState(() {
      //_events = [];
      _events.add(Marker(
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

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller.setMapStyle(Utils.mapStyle);

    locatePosition();

    setState(() {
      _events.add(
        Marker(
          markerId: const MarkerId('0'),
          position: const LatLng(65.0135579, 25.4809041),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(
            title: "Event in Oulu",
            snippet: "This event is currently taking place",
          ),
        ),
      );
    });
  }
}
