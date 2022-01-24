import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

class Prediction{
  final List<LatLng> predictionPoints;
  final List<String> predictionLocationsPlace;
  final List<String> predictionLocationsDescription;

  const Prediction({
    required this.predictionPoints,
    required this.predictionLocationsPlace,
    required this.predictionLocationsDescription
  });

  factory Prediction.fromMap(Map<String, dynamic> map){
    Map<String, dynamic> data;
    List<LatLng> coordList = [];
    List<String> placeText = [];
    List<String> descriptionText = [];
    for (var i = 0; i < 5; i++ ){
      data = Map<String, dynamic>.from(map['features'][i]);
      coordList.add(LatLng(data['geometry']['coordinates'][1], data['geometry']['coordinates'][0]));
      placeText.add(data['text']);
      descriptionText.add(data['place_name']);
      // print(data);
    }

    return Prediction(
        predictionPoints: coordList,
        predictionLocationsPlace: placeText,
        predictionLocationsDescription: descriptionText
    );
  }


}