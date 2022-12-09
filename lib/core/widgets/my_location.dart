import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({super.key, required this.lat, required this.long});
  final double lat, long;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(lat, long), zoom: 18),
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
        ),
      ),
    );
  }
}
