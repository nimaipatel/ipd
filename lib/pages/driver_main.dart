import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    var ethPrivateKey = prefs.getString('driverPrivateKey');
    var ethPublicKey = prefs.getString('driverPublicKey');

    ethPublicKey ??= "0x2A4EC1a9a5e65AAF2F8f243A29270578FCfc044c";

    setState(() {
      _ethPublicKey = ethPublicKey!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(_ethPublicKey),
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
                if (ride.driverAddress ==
                    EthereumAddress.fromHex(
                        _ethPublicKey)) {
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
            children: [Text("${_filteredRideList[index].rideID}")],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Pop here with "Nope"...
              },
              child: const Text('Nope.'),
            ),
          )
        ],
      ),
    );
  }
}
