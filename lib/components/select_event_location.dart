import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectEventLocation extends StatefulWidget {
  const SelectEventLocation({ Key? key }) : super(key: key);
  //final double lat;
  //final double lng;
  //const SelectEventLocation();

  @override
  State<SelectEventLocation> createState() => _SelectEventLocationState();
}

class _SelectEventLocationState extends State<SelectEventLocation> {
  late GoogleMapController _mapController;
  _SelectEventLocationState();
  
  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //height: MediaQuery.of(context).size.height/5,
      //width: MediaQuery.of(context).size.width/3,
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: false,
        initialCameraPosition: CameraPosition(target: LatLng(57, 13), zoom: 4),
        onMapCreated: (controller) => _mapController = controller,
        onTap: _handleOnTap,),
    );
  }

  _handleOnTap(LatLng pos) {
    Navigator.pop(context, pos);
  }
}