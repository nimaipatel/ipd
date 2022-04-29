import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";

import 'package:blockchain_ridesharing/autocomplete_model.dart';
import 'package:blockchain_ridesharing/autocomplete_repo.dart';

import 'package:blockchain_ridesharing/search_delegate_options.dart';
import 'package:blockchain_ridesharing/contract_linking.dart';
import 'package:provider/provider.dart';

import '../directions_repo.dart';

class MapPageWidget extends StatefulWidget {
  const MapPageWidget({Key? key}) : super(key: key);

  @override
  _MapPageWidgetState createState() => _MapPageWidgetState();
}

class _MapPageWidgetState extends State<MapPageWidget> {
  late Prediction res;
  final _initialCameraPosition = MapOptions(
    center: LatLng(19.0760, 72.8777),
    zoom: 10.5,
  );

  late MapController mapController = MapController();

  List<Marker> markerlist = [];
  List<LatLng> coordlist = [];

  late LatLng originCrd = LatLng(19.16150, 72.87309);
  late LatLng destinationCrd = LatLng(18.94261, 72.82313);

  late LatLngBounds boundsCntrl;
  bool markerflag = false;
  TextEditingController _originCardController = TextEditingController();
  TextEditingController _destinationCardController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // var contractLink = Provider.of<ContractLinking>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                child: FlutterMap(
                  mapController: mapController,
                  options: _initialCameraPosition,
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://api.mapbox.com/styles/v1/nike1421/ckwxapwvdgnaq14p4s3q7fbxp/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmlrZTE0MjEiLCJhIjoiY2t3eGE2cjkzMGJ3YjJ2bGF2YnB1bDlrNyJ9.9-2Wtpza6YIuPDyhpCpzSA",
                      additionalOptions: {
                        'accessToken':
                            "pk.eyJ1IjoibmlrZTE0MjEiLCJhIjoiY2t3eGE2cjkzMGJ3YjJ2bGF2YnB1bDlrNyJ9.9-2Wtpza6YIuPDyhpCpzSA",
                        'id': "mapbox.mapbox-streets-v8"
                      },
                    ),
                    MarkerLayerOptions(
                      markers: markerflag ? markerlist : [],
                    ),
                    PolylineLayerOptions(polylines: [
                      Polyline(
                          points: coordlist, strokeWidth: 5.0, color: Colors.red)
                    ])
                  ],
                ),
              ),
              Card(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*0.2,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .30,
                            child: TextFormField(
                                controller: _originCardController,
                                enabled: false,
                                decoration: const InputDecoration(
                                  labelText: 'Source',
                                )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .30,
                            child: TextFormField(
                                controller: _destinationCardController,
                                enabled: false,
                                decoration: const InputDecoration(
                                  labelText: 'Destination',
                                )),
                          )
                        ],
                      ),

                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              child: const Text(
                                'Start Ride',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                await _addMarker(originCrd, destinationCrd);
                                setState(() {
                                  _originCardController.text = "Goregaon East";
                                  _destinationCardController.text = "Marine Lines";
                                });
                              },
                              // style: ElevatedButton.styleFrom(
                              //   shape: const CircleBorder(),
                              //
                              // ),
                            ),
                            ElevatedButton(
                              child: const Text(
                                'End Ride',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              // style: ElevatedButton.styleFrom(
                              //   shape: const CircleBorder(),
                              //
                              // ),
                            ),
                          ],
                        ),

                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }

  _addMarker(LatLng originCrd, LatLng destinationCrd) async {
    Marker _origin = Marker(
      width: 80.0,
      height: 80.0,
      point: originCrd,
      builder: (ctx) => const Icon(Icons.place),
    );

    Marker _destination = Marker(
      width: 80.0,
      height: 80.0,
      point: destinationCrd,
      builder: (ctx) => const Icon(Icons.place),
    );

    // Get directions
    final directions = await DirectionsRepository()
        .getDirections(origin: _origin.point, destination: _destination.point);

    markerlist.add(_origin);
    markerlist.add(_destination);
    markerflag = true;
    coordlist = directions!.polylinePoints;
    print(coordlist);
    boundsCntrl = LatLngBounds.fromPoints(coordlist);
    mapController.fitBounds(boundsCntrl,
        options: const FitBoundsOptions(
            padding: EdgeInsets.only(top: 50, bottom: 100)));
  }


}
