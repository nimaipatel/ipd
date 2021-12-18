import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:blockchain_ridesharing/.env.dart';
import 'package:blockchain_ridesharing/autocomplete_model.dart';

class AutocompleteRepository {
  static const String _baseUrl =
      'https://api.mapbox.com/geocoding/v5/mapbox.places/';
  final Dio _dio;
  AutocompleteRepository() : _dio = Dio();

  Future<Prediction?> getPredictions({required String query}) async {
    final response = await _dio.get(
      _baseUrl + '$query.json?',
      queryParameters: {
        'access_token': mapbox_access_token,
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      // print(response.data);
      return Prediction.fromMap(json.decode(response.data));
    }
    print('Error');
    return null;
  }
}
