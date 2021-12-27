import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:blockchain_ridesharing/.env.dart';
import 'package:blockchain_ridesharing/directions_model.dart';
import "package:latlong2/latlong.dart";

class DirectionsRepository {
  static String _baseUrl =
      'https://api.mapbox.com/directions/v5/mapbox/driving/';

  final Dio _dio;

  DirectionsRepository() : _dio = Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl +
          '${origin.longitude}%2C${origin.latitude}%3B${destination.longitude}%2C${destination.latitude}?',
      queryParameters: {
        'access_token': mapbox_access_token,
        'geometries': 'polyline'
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    print('Error');
    return null;
  }
}
