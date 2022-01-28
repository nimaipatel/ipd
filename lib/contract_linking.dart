import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' show Client;
import 'package:web3dart/web3dart.dart'
    show
        ContractAbi,
        ContractFunction,
        Credentials,
        DeployedContract,
        EthereumAddress,
        Transaction,
        Web3Client;
import 'package:web_socket_channel/io.dart' show IOWebSocketChannel;

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _riderSK =
      "e7eccf1fb7a7dcdaf10bef43f8ef2627c1eaf3dd298118c3a81d7a50db7d6cac";
  final String _driverAddress = "0x2c621DF7eB184d704B6B9eB01e16Fe22fFa35D8C";

  late Web3Client _client;
  late bool isLoading = false;

  late String _abiCode;
  late EthereumAddress _contractAddress;

  late Credentials _credentials;

  late DeployedContract _contract;
  /* late ContractFunction _addDriver; */
  /* late ContractFunction _driverPool; */
  late ContractFunction _initRideBlock;
  late ContractFunction _pairRiderDriver;
  late ContractFunction _startRide;
  late ContractFunction _endRide;

  late String _deployedName;

  ContractLinking() {
    initalSetup();
  }

  initalSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiFile = await rootBundle
        .loadString("contracts/build/contracts/Main.json");
    var jsonAbi = jsonDecode(abiFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_riderSK);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Main"), _contractAddress);

    // Extracting the functions, declared in contract.
    /* _addDriver = _contract.function("addDriver"); */
    /* _driverPool = _contract.function("driverPool"); */
    _initRideBlock = _contract.function("initRideBlock");
    _pairRiderDriver = _contract.function("pairRiderDriver");
    _startRide = _contract.function("startRide");
    _endRide = _contract.function("endRide");
  }

  initRideBlock() async {
    await _client
        .call(contract: _contract, function: _initRideBlock, params: []);
    isLoading = false;
    notifyListeners();
  }

  pairRiderDriver() async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _pairRiderDriver,
            parameters: [
              EthereumAddress.fromHex(_driverAddress),
              BigInt.from(3)
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
            parameters: [BigInt.from(3)]));
  }

  endRide() async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _endRide,
            parameters: [
              BigInt.from(3),
              EthereumAddress.fromHex(_driverAddress),
            ]));
  }
}
