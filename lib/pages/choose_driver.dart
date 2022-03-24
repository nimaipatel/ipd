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
        "driverName": "Ganesh Patel",
        "driverMobile": "9999955555",
        "carRegn": "MH-04-CM-9355",
        "carMake": "Toyota",
        "carModel": "Innova",
        "currentLat": "100.00000",
        "currentLong": "100.00000"
      },
      {
        "driverID": "2",
        "driverAddress": "0xE556AbdEcC3C89820e53dD379547070817f55472",
        "driverName": "Yash Pandey",
        "driverMobile": "9494949494",
        "carRegn": "MH-04-BS-7241",
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
        Coordinates(double.parse(driverdata["currentLat"]),
            double.parse(driverdata["currentLong"])));
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
            onPressed: () async {},
            label: const Text("Refresh"),
            icon: const Icon(Icons.refresh)));
    ;
  }

  Widget _itemBuilder(BuildContext context, int index) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            child: Container(
              margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
              constraints: BoxConstraints.expand(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 4.0),
                  Text(_data.getName(index),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600
                  ),),

                  //new Text(planet.location, style: subHeaderTextStyle),
                  // Container(
                  //     margin: EdgeInsets.symmetric(vertical: 8.0),
                  //     height: 2.0,
                  //     width: 18.0,
                  //     color: Color(0xff00c6ff)),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
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
                          child: const Text('Ride'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            height: 124.0,
            margin: EdgeInsets.only(left: 20.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 141, 203, 240),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            alignment: FractionalOffset.centerLeft,
            child:  const Image(
              image:  AssetImage("assets/img/mars.png"),
              height: 92.0,
              width: 92.0,
            ),
          ),

        ],
      ),
    );
  }
}
