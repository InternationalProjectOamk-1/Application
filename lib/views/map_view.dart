//import 'package:clippy_flutter/arc.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapplication/data/events.dart';
import 'package:mapplication/models/event_model.dart';
import 'package:http/http.dart' as http;
import '../styles/map_style.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> allMarkers = [];
  late GoogleMapController _mapController;

  @override
  void initState() {
    loadMarkers();
    super.initState();
  }

  //var _state = "Loading";

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

    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng latLngPosition =
        LatLng(currentPosition.latitude, currentPosition.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 12);
    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    return;
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
            initialCameraPosition: const CameraPosition(
              target: LatLng(51.0, 13.0),
              zoom: 15,
            ),
            markers: Set<Marker>.of(allMarkers),
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
      allMarkers.add(Marker(
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
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  loadMarkers() async {
    List<EventData> markers = [];
    markers = await fetchAllEvents();

    for (int i = 0; i < markers.length; i++) {
      LatLng latlng = LatLng(markers[i].latitude!, markers[i].longitude!);
      allMarkers.add(Marker(
          markerId: MarkerId(markers[i].id.toString()),
          position: latlng,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(
            title: markers[i].title,
            snippet: markers[i].description,
            // Implement join onTap?
          )));
    }

    setState(() {
      //_state = "Ready";
    });
  }

  Future<List<EventData>> fetchAllEvents() async {
    final response = await http
        .get(Uri.parse('http://office.pepr.com:25252/Event/getAllEvents'));
    if (response.body != '[]' && response.statusCode == 200) {
      List eventResponse = json.decode(response.body);
      print('Request succesful');
      return eventResponse.map((e) => EventData.fromJson(e)).toList();
    } else {
      List eventResponseLocal = event_data;
      return eventResponseLocal.map((e) => EventData.fromJson(e)).toList();
    }
  }
}
