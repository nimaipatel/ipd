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
  final String _privateKey =
      "9f692f77c9989e265c1dbc32bbb6a0691a8234d89e0042f68f0d581e47c3e07d";

  late Web3Client _client;
  late bool isLoading = false;

  late String _abiCode;
  late EthereumAddress _contractAddress;

  late Credentials _credentials;

  late DeployedContract _contract;
  late ContractFunction _addDriver;
  late ContractFunction _driverPool;

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
        .loadString("contracts/build/contracts/DriversContract.json");
    var jsonAbi = jsonDecode(abiFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "DriversContract"), _contractAddress);

    // Extracting the functions, declared in contract.
    _addDriver = _contract.function("addDriver");
    _driverPool = _contract.function("driverPool");
  }

  getDrivers() async {
    List<dynamic> drivers = await _client
        .call(contract: _contract, function: _driverPool, params: [BigInt.from(1)]);
    isLoading = false;
    notifyListeners();
  }

  addNewDriver(String name, String carMake, String regNumber, String email,
      String resAddress) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _addDriver,
            parameters: [name, carMake, regNumber, email, resAddress]));
    getDrivers();
  }
}
