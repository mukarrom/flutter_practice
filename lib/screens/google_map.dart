import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/*
<application>
  <meta-data
  android:name="com.google.android.geo.API_KEY"
  android:value="YOUR_API_KEY_HERE"/>
</application>
*/

class TrafficMapScreen extends StatefulWidget {
  const TrafficMapScreen({super.key});

  @override
  State<TrafficMapScreen> createState() => _TrafficMapScreenState();
}

class _TrafficMapScreenState extends State<TrafficMapScreen> {
  late GoogleMapController _mapController;

  // Set of markers for different traffic conditions
  // final Set<Marker> _markers = {
  //   Marker(
  //     markerId: MarkerId('traffic_1'),
  //     position: LatLng(23.777176, 90.399452), // Example location
  //     infoWindow: InfoWindow(title: 'Heavy Traffic'),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //   ),
  //   Marker(
  //     markerId: MarkerId('traffic_2'),
  //     position: LatLng(23.780176, 90.401452), // Another location
  //     infoWindow: InfoWindow(title: 'Moderate Traffic'),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  //   ),
  //   Marker(
  //     markerId: MarkerId('traffic_3'),
  //     position: LatLng(23.775176, 90.397452), // Another location
  //     infoWindow: InfoWindow(title: 'Light Traffic'),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //   ),
  // };

  // Initial camera position
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(23.777176, 90.399452), // Latitude and Longitude
    zoom: 15,
  );

  // Set of polylines for traffic conditions
  final Set<Polyline> _polylines = {
    Polyline(
      polylineId: PolylineId('traffic_jam'),
      color: Colors.red, // Red line for traffic jam
      width: 5,
      points: [LatLng(23.777176, 90.399452), LatLng(23.780176, 90.401452)],
    ),
    Polyline(
      polylineId: PolylineId('free_traffic'),
      color: Colors.green, // Green line for free traffic
      width: 5,
      points: [LatLng(23.775176, 90.397452), LatLng(23.773176, 90.395452)],
    ),
  };

  // // Initial camera position
  // final CameraPosition _initialPosition = CameraPosition(
  //   target: LatLng(23.777176, 90.399452), // Latitude and Longitude
  //   zoom: 15,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Map with Traffic and Markers')),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        // markers: _markers, // Add markers to the map
        polylines: _polylines,
        trafficEnabled: true, // Enable traffic layer
      ),
    );
  }
}
