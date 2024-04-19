import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBody extends StatefulWidget {
  @override
  _MapBodyState createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
  late GoogleMapController mapController;
  static const LatLng _targetLocation = LatLng(13.3535, 74.7934);
  static const LatLng _additionalPoint1 = LatLng(13.348506743615102, 74.78240836254963);
  static const LatLng _additionalPoint2 = LatLng(13.371564457200865, 74.78476363629736);
  static const LatLng _additionalPoint3 = LatLng(13.371149308708704, 74.78468136471481); // Add new point
  static const LatLng _additionalPoint4 = LatLng(13.349185276562123, 74.78607762425706); // Add new point

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _targetLocation,
        zoom: 18, // Adjust the initial zoom level
      ),
      markers: {
        Marker(
          markerId: MarkerId('targetMarker'),
          position: _targetLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
        Marker(
          markerId: MarkerId('additionalPoint1'),
          position: _additionalPoint1,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
        Marker(
          markerId: MarkerId('additionalPoint2'),
          position: _additionalPoint2,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
        Marker(
          markerId: MarkerId('additionalPoint3'), // Add marker for additional point 3
          position: _additionalPoint3,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange), // Change marker color to green
        ),
        Marker(
          markerId: MarkerId('additionalPoint4'), // Add marker for additional point 4
          position: _additionalPoint4,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen), // Change marker color to yellow
        ),
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}