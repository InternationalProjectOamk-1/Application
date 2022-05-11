import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapplication/styles/map_style.dart';

class SmallMapScreen extends StatefulWidget {
  //const SmallMapScreen({ Key? key, this.lat, this.lng }) : super(key: key);
  final double lat;
  final double lng;
  const SmallMapScreen(this.lat, this.lng);

  @override
  State<SmallMapScreen> createState() => _SmallMapScreenState();
}

class _SmallMapScreenState extends State<SmallMapScreen> {
  late GoogleMapController _mapController;
  _SmallMapScreenState();
  
  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/5,
      width: MediaQuery.of(context).size.width/3,
      child: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        tiltGesturesEnabled: false,
        initialCameraPosition: CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 12),
        onMapCreated: _onMapCreated,
        markers: {
          Marker(position: LatLng(widget.lat, widget.lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          markerId: const MarkerId('event_id'))
        },),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller.setMapStyle(Utils.mapStyle);
  }
}