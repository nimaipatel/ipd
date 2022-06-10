import 'package:shared_preferences/shared_preferences.dart';

import '../riders.dart';
import '../contract_linking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/credentials.dart';
import 'package:blockchain_ridesharing/ipfs_connect.dart';

class ChooseDriver extends StatefulWidget {
  const ChooseDriver({Key? key}) : super(key: key);

  @override
  State<ChooseDriver> createState() => _ChooseDriverState();
}

class DriverData {
  late List _data;
  DriverData(List _fetchedData) {
    _data = _fetchedData;
  }

  String getId(int index) {
    return _data[index]["_id"];
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
        BigInt.parse(driverdata["_id"]),
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
  late DriverData driverData = DriverData([]);
  late Driver chosenDriver;
  late List fetchedData;
  late int dataLength = 0;
  late int riderLat = 100;
  late int riderLong = 100;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRidersLocation();
  }

  Future<void> getRidersLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // await prefs.setInt('riderLat', 100);
    // await prefs.setInt('riderLong', 100);

    var lat = prefs.getInt('lat');
    var long = prefs.getInt('long');

    setState(() {
      riderLat = lat!;
      riderLong = long!;
    });
    print("Values Set");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Driver Main'),
          centerTitle: true,
        ),
        body: Column(
          children: [

            ListView.builder(
              padding: const EdgeInsets.all(5.5),
              itemCount: driverData.getLength(),
              itemBuilder: _itemBuilder,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
            ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              fetchedData = await requestAllDrivers(riderLat, riderLong);
              // print(fetchedData);
              setState(() {
                driverData = DriverData(fetchedData);
                dataLength = driverData.getLength();
              });

              // print(dataLength);
            },
            label: const Text("Refresh"),
            icon: const Icon(Icons.refresh)));
  }

  Future<List> requestAllDrivers(int riderLat, int riderLong) async {
    var fetchedData = await OrbitDBConnector().getDrivers(riderLat, riderLong);
    return fetchedData.data;
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
        children: dataLength == 0
            ? []
            : <Widget>[
                Container(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
                    constraints: const BoxConstraints.expand(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 4.0),
                        Text(
                          driverData.getName(index),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  chosenDriver = driverData.getDriver(index);
                                  await contractLink.pairRiderDriver(
                                      chosenDriver.driverAddress);
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
                  margin: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 141, 203, 240),
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
                  child: const Image(
                    image: AssetImage("assets/img/mars.png"),
                    height: 92.0,
                    width: 92.0,
                  ),
                ),
              ],
      ),
    );
  }
}
