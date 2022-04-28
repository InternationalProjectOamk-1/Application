//import 'package:clippy_flutter/arc.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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

    print('You are currently at: $currentPosition');
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var position;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 11);
    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    return;

    //Position position = await Geolocator.getCurrentPosition(
    //    desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
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
            padding: const EdgeInsets.only(top: 31.0),
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(currentPosition.latitude, currentPosition.longitude),
              zoom: 12,
            ),
            markers: _events,
            onLongPress: _handleLongPress,
            onMapCreated: _onMapCreated,
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
    //LocationData currentLocation;
    //currentLocation = await location.getLocation();
    _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude))));

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
