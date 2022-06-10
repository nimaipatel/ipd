import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class OrbitDBConnector extends ChangeNotifier {
  static const String _baseUrl = "http://10.0.2.2:3000/";
  final Dio _dio;
  late bool isLoading = false;
  OrbitDBConnector() : _dio = Dio();

  Future<Response> getDrivers(int riderLat, int riderLong) async {
    final response = await _dio.get(_baseUrl + "getCloseDrivers",
        queryParameters: {
          "name": "test",
          "currentLat": riderLat,
          "currentLong": riderLong
        });
    isLoading = false;
    notifyListeners();
    if (response.statusCode == 200) {
      return response;
    }
    return Future.error("error");
  }

  Future<Response> addDriver(
      String driverEthAddress,
      String driverName,
      String driverMobile,
      String carRegn,
      String carMake,
      String carModel
      ) async {
    final response = await _dio.post(_baseUrl + 'addDriver', data: {
      "_id": "3",
      "driverAddress": driverEthAddress,
      "driverName": driverName,
      "driverMobile": driverMobile,
      "carRegn": carRegn,
      "carMake": carMake,
      "carModel": carModel,
      "currentLat": "50",
      "currentLong": "50"
    });
    print(response);
    if (response.statusCode == 200) {
      return response;
    }
    return response;
  }
}
