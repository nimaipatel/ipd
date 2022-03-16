import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/credentials.dart';

import '../contract_linking.dart';

class DriverMainPage extends StatefulWidget {
  const DriverMainPage({Key? key}) : super(key: key);

  @override
  _DriverMainPageState createState() => _DriverMainPageState();
}

class RideData {
  Map fetchedData = {
    "rides": [
      {
        "rideId": "1",
        "riderAddress": "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
        "pickupLocation": "Goregaon East",
        "dropoffLocation": "Marine Drive",
        "pickupLocationLatitude": "",
        "pickupLocationLongitude": "",
        "dropoffLocationLatitude": "",
        "dropoffLocationLongitude": ""
      }
    ]
  };

  late List _data;
  RideData() {
    _data = fetchedData["rides"];
  }

  String getId(int index) {
    return _data[index]["pickupLocation"];
  }

  String getName(int index) {
    return _data[index]["riderAddress"];
  }

  int getLength() {
    return _data.length;
  }
}

class _DriverMainPageState extends State<DriverMainPage> {
  // final RideData _data = RideData();
  List _rideList = [];
  List _filteredRideList = [];
  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    // _rideList = contractLink.getRides();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Driver Main'),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(5.5),
          itemCount: _filteredRideList.length,
          itemBuilder: _itemBuilder,
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              _rideList = await contractLink.getRides();
              for (var ride in _rideList) {
                if (ride.driverAddress == EthereumAddress.fromHex("0x2A4EC1a9a5e65AAF2F8f243A29270578FCfc044c")) {
                  _filteredRideList.add(ride);
                }
              }

            },
            label: const Text("Refresh"),
            icon: const Icon(Icons.refresh)));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Card(
      child: Row(
        children: [
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            height: 75.0,
            width: 75.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
          Column(
            children:  [
              Text("${_filteredRideList[index].rideID}")

            ],
          )
        ],
      ),
    );
  }
}
