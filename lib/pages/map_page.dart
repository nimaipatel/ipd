import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:latlong/latlong.dart";

import 'package:blockchain_ridesharing/autocomplete_model.dart';
import 'package:blockchain_ridesharing/autocomplete_repo.dart';

import 'package:blockchain_ridesharing/search_delegate_options.dart';

class MapPageWidget extends StatefulWidget {
  const MapPageWidget({Key? key}) : super(key: key);

  @override
  _MapPageWidgetState createState() => _MapPageWidgetState();
}

class _MapPageWidgetState extends State<MapPageWidget> {
  late Prediction res;
  TextEditingController _originController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
          visible: true,
          child: Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .70,
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

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Rio Haryanto"),
                                    Text("MH-XX-XX-XXXX"),
                                    Text("Silver Toyota Innova")
                                  ],
                                ),
                              ),
                              Column(
                                children: const [
                                  Icon(Icons.call),
                                  Icon(Icons.close)
                                ],
                              )
                            ],
                          ),
                        )),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 10.0, horizontal: 15.0),
                    //         child: SizedBox(
                    //           width:
                    //           MediaQuery.of(context).size.width * .30,
                    //           child: ElevatedButton(
                    //               onPressed: () {},
                    //               child: const Text('Cancel'),
                    //               style: ElevatedButton.styleFrom(
                    //                   shape: RoundedRectangleBorder(
                    //                       borderRadius:
                    //                       BorderRadius.circular(5.0)))),
                    //         )),
                    //     Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 10.0, horizontal: 15.0),
                    //         child: SizedBox(
                    //           width:
                    //           MediaQuery.of(context).size.width * .30,
                    //           child: ElevatedButton(
                    //               onPressed: () {},
                    //               child: const Text('Call'),
                    //               style: ElevatedButton.styleFrom(
                    //                   shape: RoundedRectangleBorder(
                    //                       borderRadius:
                    //                       BorderRadius.circular(5.0)))),
                    //         ))
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .30,
                          child: const TextField(
                            enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Source',
                              )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .30,
                          child: const TextField(
                            enabled: false,
                              decoration: InputDecoration(
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
          )),
    );
  }
}
