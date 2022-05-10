import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectEventLocation extends StatefulWidget {
  //const SelectEventLocation({ Key? key }) : super(key: key);
  //final double lat;
  //final double lng;
  //const SmallMapScreen(this.lat, this.lng);

  @override
  State<SelectEventLocation> createState() => _SelectEventLocationState();
}

class _SelectEventLocationState extends State<SelectEventLocation> {
  late GoogleMapController _mapController;
  
  
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
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        tiltGesturesEnabled: false,
        initialCameraPosition: CameraPosition(target: LatLng(1, 1), zoom: 12),
        onMapCreated: (controller) => _mapController = controller,
        onTap: _handleOnTap,),
    );
  }

  _handleOnTap(LatLng pos) {

  }
}