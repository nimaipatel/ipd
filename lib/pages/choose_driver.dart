import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/credentials.dart';

import '../contract_linking.dart';
import '../riders.dart';

class ChooseDriver extends StatefulWidget {
  const ChooseDriver({Key? key}) : super(key: key);

  @override
  State<ChooseDriver> createState() => _ChooseDriverState();
}

// Till IPFS does not work
class DriverData {
  Map fetchedData = {
    "drivers": [
      {
        "driverID": "1",
        "driverAddress": "0x2A4EC1a9a5e65AAF2F8f243A29270578FCfc044c",
        "driverName": "First Last",
        "driverMobile": "9999955555",
        "carRegn": "MH-XX-XX-XXXX",
        "carMake": "Toyota",
        "carModel": "Innova",
        "currentLat": "100.00000",
        "currentLong": "100.00000"
      },
      {
        "driverID": "2",
        "driverAddress": "0x2A4EC1a9a5e65Aasdfgf243A29270578FCfc044c",
        "driverName": "First1 Last1",
        "driverMobile": "9494949494",
        "carRegn": "MH-XX-XX-XXXX",
        "carMake": "Maruti Suzuki",
        "carModel": "Baleno",
        "currentLat": "50.00000",
        "currentLong": "50.00000"
      },
    ]
  };

  late List _data;
  DriverData() {
    _data = fetchedData["drivers"];
  }

  String getId(int index) {
    return _data[index]["driverID"];
  }

  String getName(int index) {
    return _data[index]["driverName"];
  }

  int getLength() {
    return _data.length;
  }

  Driver getDriver(int index) {
    var driverdata = _data[index];
    Driver _chosenDriver = Driver(
        BigInt.parse(driverdata["driverID"]),
        EthereumAddress.fromHex(driverdata["driverAddress"]),
        driverdata["driverName"],
        BigInt.parse(driverdata["driverMobile"]),
        driverdata["carMake"],
        driverdata["carModel"],
        driverdata["carRegn"],
        Coordinates(
            double.parse(driverdata["currentLat"]),
            double.parse(driverdata["currentLong"])
        )
    );
    return _chosenDriver;
  }
}

class _ChooseDriverState extends State<ChooseDriver> {
  final DriverData _data = DriverData();
  late Driver chosenDriver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Driver Main'),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(5.5),
          itemCount: _data.getLength(),
          itemBuilder: _itemBuilder,
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              // _rideList = await contractLink.getRides();
              // for (var ride in _rideList) {
              //   if (ride.driverAddress == EthereumAddress.fromHex("0x2A4EC1a9a5e65AAF2F8f243A29270578FCfc044c")) {
              //     _filteredRideList.add(ride);
              //   }
              // }
            },
            label: const Text("Refresh"),
            icon: const Icon(Icons.refresh)));
    ;
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var contractLink = Provider.of<ContractLinking>(context);
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
            children: [
              // Text("${_filteredRideList[index].rideID}")
              Text(_data.getId(index))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                // Pop here with "Nope"...
                // Navigator.pop(context, );
                chosenDriver = _data.getDriver(index);
                await contractLink
                    .pairRiderDriver(
                    chosenDriver.driverAddress
                );
                Navigator.pop(context, chosenDriver);
              },
              child: const Text('Nope.'),
            ),
          )
        ],
      ),
    );
  }
}
