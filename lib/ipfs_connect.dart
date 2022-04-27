import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class OrbitDBConnector extends ChangeNotifier{
  static const String _baseUrl = "http://10.0.2.2:3000/";
  final Dio _dio;
  late bool isLoading = false;
  OrbitDBConnector() : _dio = Dio();

  Future<Response> getDrivers(int riderLat, int riderLong) async {
    final response = await _dio.get(
      _baseUrl + "getCloseDrivers",
      queryParameters: {
        "name": "test",
        "currentLat" : riderLat,
        "currentLong" : riderLong
      }
    );
    isLoading = false;
    notifyListeners();
    if (response.statusCode == 200){
      return response;
    }
    return Future.error("error");
  }

  Future<Response> addDriver() async{
    final response = await _dio.post(
      _baseUrl + 'addDriver',
      data: {
              "_id": "3",
              "driverAddress": "0x97ea08CdC58241a615856F4AC9C5de98074Fdd86",
              "driverName": "Panil Yesh",
              "driverMobile": "9494949494",
              "carRegn": "MH-04-BS-7241",
              "carMake": "Maruti Suzuki",
              "carModel": "Baleno",
              "currentLat": "50",
              "currentLong": "50"
            }
    );
    print(response);
    if (response.statusCode == 200){
      return response;
    }
    return response;
  }


}