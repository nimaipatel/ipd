import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';

class Directions {
  // final LatLngBounds bounds;
  final List<LatLng> polylinePoints;
  final double totalDistance;
  final double totalDuration;

  const Directions({
    // required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    // // Check if route is not available
    // if ((map['routes'] as List).isEmpty) return null;

    // Get route information
    final data = Map<String, dynamic>.from(map['routes'][0]);

    // // Bounds
    // final northeast = data['bounds']['northeast'];
    // final southwest = data['bounds']['southwest'];
    // final bounds = LatLngBounds(
    //   northeast: LatLng(northeast['lat'], northeast['lng']),
    //   southwest: LatLng(southwest['lat'], southwest['lng']),
    // );

    // Distance & Duration
    double distance = 0.0;
    double duration = 0.0;
    List<PointLatLng> polylines = [];
    List<LatLng> latlist = [];
    // print(data);
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance'];
      duration = leg['duration'];
      polylines = PolylinePoints().decodePolyline(data['geometry']);



      for (var value in polylines){
        latlist.add(
            LatLng(value.latitude, value.longitude)
        );
        print(latlist);
      }
    }

    return Directions(
      // bounds: bounds,
      polylinePoints: latlist,
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}
