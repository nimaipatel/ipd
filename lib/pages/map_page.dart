import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:latlong/latlong.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:blockchain_ridesharing/directions_repo.dart';
import 'package:blockchain_ridesharing/directions_model.dart';

class MapPageWidget extends StatefulWidget {
  const MapPageWidget({Key? key}) : super(key: key);

  @override
  _MapPageWidgetState createState() => _MapPageWidgetState();
}

class _MapPageWidgetState extends State<MapPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppName'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMarker,
      ),
    );
  }

  void _addMarker() async {
    Marker _origin = Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(37.77, -122.41),
      builder: (ctx) => Container(
        child: FlutterLogo(),
      ),
    );

    Marker _destination = Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(34.05, -118.24),
      builder: (ctx) => Container(
        child: FlutterLogo(),
      ),
    );

    Directions _info;
    // Get directions
    final directions = await DirectionsRepository()
        .getDirections(origin: _origin.point, destination: _destination.point);
    setState(() => _info = directions!);
    print(directions);
  }
}
