import 'dart:convert' show jsonDecode, jsonEncode;
import 'package:blockchain_ridesharing/riders.dart';
import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' show Client;
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart'
    show ContractAbi, ContractEvent, ContractFunction, Credentials, DeployedContract, EthPrivateKey, EtherAmount, EthereumAddress, FilterOptions, Transaction, Wallet, Web3Client;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart' show IOWebSocketChannel;

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _riderSK =
      "452a1e3f893f88db62dfe874ac2356885306cbb9beabf69becd6f4341dd7954c";


  // final String _driverAddress = "0xE556AbdEcC3C89820e53dD379547070817f55472";


  late Web3Client _client;
  late bool isLoading = false;

  late String _abiCode;
  late EthereumAddress _contractAddress;

  late Credentials _credentials;
  late EthPrivateKey _ethKey;

  late DeployedContract _contract;
  late ContractFunction _rideCount;
  late ContractFunction _Rides;

  late ContractFunction _initRideBlock;
  late ContractFunction _pairRiderDriver;
  late ContractFunction _startRide;
  late ContractFunction _endRide;

  late ContractEvent _transferEvent;

  late String _deployedName;

  late int ridesCount;
  late List rideList;

  ContractLinking() {
    initalSetup();
  }

  // Add this Functionality later
  // Future<void> getRiderAddress() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // var add =  prefs.getString('riderLat');
  //
  //
  //   // setState(() {
  //   //   _ethPublicKey = ethPublicKey!;
  //   // });
  // }

  initalSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiFile =
        await rootBundle.loadString("contracts/build/contracts/Main.json");
    var jsonAbi = jsonDecode(abiFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_riderSK);
    _ethKey = EthPrivateKey.fromHex(_riderSK);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Main"), _contractAddress);

    _rideCount = _contract.function("rideCount");
    _Rides = _contract.function("Rides");

    _initRideBlock = _contract.function("initRideBlock");
    _pairRiderDriver = _contract.function("pairRiderDriver");
    _startRide = _contract.function("startRide");
    _endRide = _contract.function("endRide");
  }

  getRideCount() async {
    rideList = await _client
        .call(contract: _contract, function: _rideCount, params: []);
    var totalRides = rideList[0];
    ridesCount = totalRides.toInt();
    print(ridesCount);
    return ridesCount;
  }

  RideStatus getRideStatus(BigInt rideStatusIndex) {
    RideStatus rideStatus;
    if (rideStatusIndex == BigInt.from(0)){
      rideStatus = RideStatus.Booked;
    }else if (rideStatusIndex == BigInt.from(1)){
      rideStatus = RideStatus.InProgress;
    }else if(rideStatusIndex == BigInt.from(2)){
      rideStatus = RideStatus.Completed;
    }else {
      rideStatus = RideStatus.Cancelled;
    }
    return rideStatus;
  }

  // get rides
  getRides() async {
    ridesCount = await getRideCount();
    print(ridesCount);
    rideList.clear();
    for (var i = 0; i < ridesCount.toInt(); i++) {
      var temp = await _client.call(
          contract: _contract, function: _Rides, params: [BigInt.from(i)]);
      // print(temp[4][0] is BigInt);
      var rideStatus = getRideStatus(temp[3]);
      Coordinates pickupCoord = Coordinates((temp[4][0]).toInt()/100000, (temp[4][1]).toInt()/100000.toDouble());
      Coordinates dropoffCoord = Coordinates((temp[5][0].toInt())/100000.toDouble(), (temp[5][1].toInt())/100000.toDouble());
      rideList.add(Ride(temp[0], temp[1], temp[2], rideStatus,pickupCoord, dropoffCoord,
          temp[6], temp[7], temp[8], temp[9]));
      // print(pickupCoord);
      print(temp[3] is BigInt);
    }

    isLoading = false;
    notifyListeners();
    return rideList;
  }

  initRideBlock(LatLng originCrd, LatLng destinationCrd) async {
    isLoading = true;
    notifyListeners();
    await getRides();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _initRideBlock,
            parameters: [
              BigInt.from((originCrd.latitude) * 100000),
              BigInt.from((originCrd.longitude) * 100000),
              BigInt.from((destinationCrd.latitude) * 100000),
              BigInt.from((destinationCrd.longitude) * 100000)
            ]));

    ridesCount++;
    isLoading = false;
    notifyListeners();
  }

  pairRiderDriver(EthereumAddress _driverAddress) async {
    isLoading = true;
    notifyListeners();

    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _pairRiderDriver,
            parameters: [
              _driverAddress,
              BigInt.from(ridesCount - 1)
            ]));
  }


  startRide() async {
    isLoading = true;
    notifyListeners();

    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _startRide,
            parameters: [BigInt.from(ridesCount - 1)]));
  }

  // Added value parameter to callContract, make sure to fix final parts
  endRide(String _driverAddress) async {
    isLoading = true;
    notifyListeners();

    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _endRide,
            value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 1),
            parameters: [
              BigInt.from(ridesCount - 1),
              EthereumAddress.fromHex(_driverAddress),
            ]));
  }
}





