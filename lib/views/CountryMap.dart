import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CountryMap extends StatelessWidget {
  final Map country;
  Completer<GoogleMapController> _controller = Completer();

  CountryMap(this.country);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country['name']),
        backgroundColor: Colors.pink,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(country['latlng'][0], country['latlng'][1]),
          zoom: 6,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
