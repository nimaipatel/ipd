import 'package:blockchain_ridesharing/riders.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:blockchain_ridesharing/directions_repo.dart';
import 'package:blockchain_ridesharing/autocomplete_model.dart';
import 'package:blockchain_ridesharing/search_delegate_options.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:blockchain_ridesharing/contract_linking.dart';
import 'choose_driver.dart';


class BookRide extends StatefulWidget {
  const BookRide({Key? key}) : super(key: key);

  @override
  _BookRideState createState() => _BookRideState();
}

class _BookRideState extends State<BookRide> {
  final _initialCameraPosition = MapOptions(
    center: LatLng(19.0760, 72.8777),
    zoom: 10.5,
  );

  late MapController mapController = MapController();

  late Marker _origin;
  late Marker _destination;

  late LatLng destinationCrd;
  late LatLng originCrd;

  late Prediction res;

  late double rideDuration;
  late double rideDistance;

  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  TextEditingController _originCardController = TextEditingController();
  TextEditingController _destinationCardController = TextEditingController();

  List<Marker> markerlist = [];
  List<LatLng> coordlist = [];

  bool visibleCont = true;
  bool visibleText = false;
  bool visibleTopMenu = true;

  String buttonText = "_addmarker";
  late Driver selectedDriver;

  // Structure for Ride Struct for Blockchain

  @override
  void toggleState() {
    setState(() {
      visibleText = !visibleText;
      buttonText = "Check Availability";
    });
  }

  void removeTopMenu() {
    setState(() {
      visibleTopMenu = false;
    });
  }

  // Async function to navigate to driver select page
  Future<Driver> selectDriverMenu(BuildContext context) async {
    final selectedDriver = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChooseDriver()),
    );

    return selectedDriver;
  }

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Ride'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Visibility(
                      visible: visibleTopMenu,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 141, 203, 240),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0))),
                        height: 200.0,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 15.0, 15.0, 7.5),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: TextFormField(
                                            controller: _originController,
                                            onTap: () async {
                                              final res = await showSearch(
                                                  context: context,
                                                  delegate: AutoSearch());
                                              _originController.text = res!
                                                  .predictionLocationsDescription[0];
                                              _originCardController.text = res
                                                  .predictionLocationsPlace[0];
                                              originCrd =
                                                  res.predictionPoints[0];
                                            },
                                            // // Show the search delegate here
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              labelText: 'Source',
                                            ))))),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 15.0, 15.0, 7.5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: TextFormField(
                                    controller: _destinationController,
                                    onTap: () async {
                                      final res = await showSearch(
                                          context: context,
                                          delegate: AutoSearch());
                                      _destinationController.text = res!
                                          .predictionLocationsDescription[0];
                                      _destinationCardController.text =
                                          res.predictionLocationsPlace[0];
                                      destinationCrd = res.predictionPoints[0];
                                    }, // the search delegate here
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Destination',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Add the distance and duration and cost later
                            Visibility(
                                visible: visibleText,
                                child: Text("Estimated Time: ")),
                            Visibility(
                                visible: visibleText,
                                child: Text("Distance: ")),
                          ],
                        ),
                      )),
                  Container(
                    color: Colors.grey,
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
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
                      markers: visibleText ? [] : markerlist,
                    ),
                    PolylineLayerOptions(polylines: [
                      Polyline(
                          points: coordlist,
                          strokeWidth: 5.0,
                          color: Colors.red)
                    ])
                  ],
                ),
              ),
              Visibility(
                  visible: !visibleTopMenu,
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .60,
                        right: 20.0,
                        left: 20.0),
                    child: Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15.0),
                                child: Card(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 15.0),
                                        height: 75.0,
                                        width: 75.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: visibleTopMenu
                                              ? []
                                              : [
                                                  Text(selectedDriver
                                                      .driverName),
                                                  Text(selectedDriver
                                                      .carRegistration),
                                                  Text(selectedDriver.carMake)
                                                ],
                                        ),
                                      ),
                                      Column(
                                        children: [

                                          ConstrainedBox(
                                            constraints:
                                                const BoxConstraints.tightFor(
                                                    width: 30, height: 30),
                                            child: ElevatedButton(
                                              child: const Text(
                                                'Com',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              onPressed: () async {
                                                await contractLink.startRide();
                                                await contractLink.getRides();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: const CircleBorder(),
                                              ),
                                            ),
                                          ),
                                          ConstrainedBox(
                                            constraints:
                                                const BoxConstraints.tightFor(
                                                    width: 30, height: 30),
                                            child: ElevatedButton(
                                              child: const Text(
                                                'Con',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              onPressed: () async {
                                                contractLink.endRide();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: const CircleBorder(),
                                              ),
                                            ),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .30,
                                  child: TextFormField(
                                      controller: _originCardController,
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        labelText: 'Source',
                                      )),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .30,
                                  child: TextFormField(
                                      controller: _destinationCardController,
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        labelText: 'Destination',
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                        color: Colors.white,
                        elevation: 4.0,
                      ),
                    ),
                  ))
            ],
          ),
        ),
        floatingActionButton: !visibleText
            ? Visibility(
                child: FloatingActionButton.extended(
                    onPressed: () async {
                      await _addMarker(originCrd, destinationCrd);
                      await contractLink.initRideBlock(
                          originCrd, destinationCrd);
                      toggleState();
                      //
                    },
                    label: const Text("buttonText"),
                    icon: const Icon(Icons.car_rental)))
            : Visibility(
                visible: visibleTopMenu,
                child: FloatingActionButton.extended(
                    onPressed: () async {

                      selectedDriver = await selectDriverMenu(context);
                      removeTopMenu();
                    },
                    label: Text(buttonText),
                    icon: const Icon(Icons.car_rental)),
              ));
  }

  _addMarker(LatLng originCrd, LatLng destinationCrd) async {
    _origin = Marker(
      width: 80.0,
      height: 80.0,
      point: originCrd,
      builder: (ctx) => const Icon(Icons.place),
    );

    _destination = Marker(
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

    coordlist = directions!.polylinePoints;
    rideDuration = directions.totalDuration;
    rideDistance = directions.totalDistance;

    var boundsCntrl = LatLngBounds.fromPoints(coordlist);
    mapController.fitBounds(boundsCntrl,
        options: const FitBoundsOptions(
            padding: EdgeInsets.only(top: 50, bottom: 100)));

  }
}
