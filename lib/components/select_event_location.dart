import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapplication/styles/map_style.dart';

class SelectEventLocation extends StatefulWidget {
  const SelectEventLocation({ Key? key }) : super(key: key);
  

  @override
  State<SelectEventLocation> createState() => _SelectEventLocationState();
}

class _SelectEventLocationState extends State<SelectEventLocation> {
  late GoogleMapController _mapController;
  Position? currentPosition;
  var geoLocator = Geolocator();
  _SelectEventLocationState();
  
  @override
  void initState() {
    locatePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: false,
        padding: const EdgeInsets.only(top: 31.0),
        initialCameraPosition: const CameraPosition(
                target: LatLng(50,15),
                zoom: 1,
              ),
        onMapCreated: _onMapCreated,
        onTap: _handleOnTap,),
    );
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

  _handleOnTap(LatLng pos) {
    Navigator.pop(context, pos);
  }

    _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller.setMapStyle(Utils.mapStyle);
    setState(() {});
  }
}