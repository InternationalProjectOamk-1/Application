import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapplication/models/event_model.dart';
import 'package:mapplication/views/create_event_from_map.dart';
import '../styles/map_style.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> allMarkers = [];
  List<Marker> userMarker = [];

  late GoogleMapController _mapController;
  var _state = 'Loading';
  Position? currentPosition;
  var geoLocator = Geolocator();

  @override
  void initState() {
    loadMarkers();
    locatePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == 'Loading') {
      return const Center(child: CircularProgressIndicator());
    } else if (_state == 'Complete') {
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
              compassEnabled: true,
              padding: const EdgeInsets.only(top: 31.0),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: const CameraPosition(
                target: LatLng(50,15),
                zoom: 1,
              ),
              markers: Set<Marker>.of(allMarkers),
              onLongPress: _handleLongPress,
              onMapCreated: _onMapCreated,
            ),
          )
        ],
      );
    } else {
      return const Scaffold(body: Center(child: Text('Something went wrong')));
    }
  }

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

  _handleLongPress(LatLng pos) {
    setState(() {
      allMarkers.add(Marker(
        markerId: MarkerId(pos.toString()),
        position: pos,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateEventScreenFromMap(
                        sendedpos: pos,
                      ))),
          title: 'New Event',
          snippet: 'Tap here to create a new event!',
        ),
      ));
    });
  }

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller.setMapStyle(Utils.mapStyle);
    setState(() {});
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
      _state = "Complete";
    });
  }
}
