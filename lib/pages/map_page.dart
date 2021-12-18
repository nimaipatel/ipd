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
      appBar: AppBar(
        title: const Text('AppName'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
        height: 200.0,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 7.5),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextFormField(
                            controller: _originController,
                            onTap: () async {
                              final res = await showSearch(
                                  context: context, delegate: AutoSearch());
                              _originController.text = res!.predictionLocationsDescription[0];
                              print(res.predictionPoints[0].longitude);
                            }, // Show the search delegate here
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Source',
                            ))))),
          ],
        ),
      ),
    );
  }
}
