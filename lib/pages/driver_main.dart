import 'package:blockchain_ridesharing/riders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';
import '../contract_linking.dart';

class DriverMainPage extends StatefulWidget {
  const DriverMainPage({Key? key}) : super(key: key);

  @override
  _DriverMainPageState createState() => _DriverMainPageState();
}

class _DriverMainPageState extends State<DriverMainPage> {
  List _rideList = [];
  List _filteredRideList = [];

  String _ethPublicKey = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEthereumKey();
  }

  Future<void> getEthereumKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // var ethPrivateKey = prefs.getString('driverPrivateKey');
    var ethPublicKey = prefs.getString('driverPublicKey');
    print(ethPublicKey);
    ethPublicKey ??= "0x2A4EC1a9a5e65AAF2F8f243A29270578FCfc044c";

    setState(() {
      _ethPublicKey = ethPublicKey!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);

    populateRidelist() async {
      _rideList.clear();
      _filteredRideList.clear();
      _rideList = await contractLink.getRides();
      for (var ride in _rideList) {
        if (ride.driverAddress == EthereumAddress.fromHex(_ethPublicKey) &&
            ride.rideState != RideStatus.Cancelled) {
          _filteredRideList.add(ride);
        }
      }
    }

    // _rideList = contractLink.getRides();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Driver"),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(5.5),
          itemCount: _filteredRideList.length,
          itemBuilder: _itemBuilder,
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              populateRidelist();
            },
            label: const Text("Refresh"),
            icon: const Icon(Icons.refresh)));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    // return Card(
    //   child: Row(
    //     children: [
    //       Container(
    //         margin:
    //             const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    //         height: 75.0,
    //         width: 75.0,
    //         decoration: const BoxDecoration(
    //           shape: BoxShape.circle,
    //           color: Colors.red,
    //         ),
    //       ),
    //       Column(
    //         children: [Text("${_filteredRideList[index].rideID}")],
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: ElevatedButton(
    //           onPressed: () {
    //             Navigator.pushNamed(context, '/map');
    //           },
    //           child: const Text('Ride!'),
    //         ),
    //       )
    //     ],
    //   ),
    // );
    return Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: Stack(
        children: _filteredRideList.isEmpty
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
                    // "${_filteredRideList[index].rideID}",
                    "Goregaon East",
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
                            _filteredRideList.clear();
                            Navigator.pushNamed(context, '/map');

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
            // margin: const EdgeInsets.only(left: 20.0),
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

        ],
      ),
    );
  }
}
