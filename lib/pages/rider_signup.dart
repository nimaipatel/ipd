import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:blockchain_ridesharing/ipfs_connect.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RiderRegistrationForm extends StatefulWidget {
  const RiderRegistrationForm({Key? key}) : super(key: key);

  @override
  _RiderRegistrationFormState createState() => _RiderRegistrationFormState();
}

class _RiderRegistrationFormState extends State<RiderRegistrationForm> {
  final _RiderRegistrationFormKey = GlobalKey<FormState>();

  // Registration Controllers to send the data to the IPFS Server
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ethPublicKeyController = TextEditingController();
  final TextEditingController _ethPrivateKeyController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _ethAddressController = TextEditingController();
  // final TextEditingController _carRegnController = TextEditingController();
  // final TextEditingController _phoneNumberController = TextEditingController();
  // final TextEditingController _carMakeController = TextEditingController();
  // final TextEditingController _carModelController = TextEditingController();

  Future<bool> saveWallet(String walletJsonString) async {
    late Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          print(directory.path);
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/Wallet.json");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        // Add code for download
        saveFile.writeAsString(walletJsonString);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppName'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Center(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: Text(
                "Register on the App",
                style: TextStyle(fontSize: 50.0, color: Colors.black),
                textAlign: TextAlign.left,
              ),
            )),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 141, 203, 240),
                  borderRadius: BorderRadius.circular(20.0)),
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: const EdgeInsets.only(top: 10.0),
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                key: _RiderRegistrationFormKey,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.badge),
                            border: InputBorder.none,
                            labelText: 'Name',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.badge),
                            border: InputBorder.none,
                            labelText: 'Mobile No.',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: InputBorder.none,
                            labelText: 'Email ID',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          controller: _cityController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.smartphone),
                            border: InputBorder.none,
                            labelText: 'City',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          controller: _ethPublicKeyController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key),
                            border: InputBorder.none,
                            labelText: 'Public Key',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          controller: _ethPrivateKeyController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.add_location),
                            border: InputBorder.none,
                            labelText: 'Private Key',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.smartphone),
                            border: InputBorder.none,
                            labelText: 'Password',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 25.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            final password = _passwordController.text;
                            final EthPrivateKey credentials =
                                EthPrivateKey.fromHex(
                                    _ethPrivateKeyController.text);
                            final random = Random.secure();
                            final wallet =
                                Wallet.createNew(credentials, password, random);

                            final prefs = await SharedPreferences.getInstance();
                            var walletJson = json.encode(wallet.toJson());
                            print(walletJson);
                            prefs.setString("wallet", walletJson);
                            bool saved = await saveWallet(walletJson);
                            if (saved){
                              print("User saved");
                            }
                            // await OrbitDBConnector().addDriver(
                            //     _ethAddressController.text,
                            //     _nameController.text,
                            //     _phoneNumberController.text,
                            //     _carRegnController.text,
                            //     _carMakeController.text,
                            //     _carModelController.text);
                            // final SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            //
                            // String publicEthKey = _ethAddressController.text;
                            // await prefs.setString(
                            //     'driverPublicKey', publicEthKey);

                            Navigator.pushNamed(context, '/riderBook');
                          },
                          child: const Text('Register'),
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all<Size>(
                                  const Size.fromHeight(50.0)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0)))),
                        ),
                      )),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
