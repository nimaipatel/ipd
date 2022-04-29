import 'package:blockchain_ridesharing/ipfs_connect.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiderRegistrationForm extends StatefulWidget {
  const RiderRegistrationForm({Key? key}) : super(key: key);

  @override
  _RiderRegistrationFormState createState() => _RiderRegistrationFormState();
}

class _RiderRegistrationFormState extends State<RiderRegistrationForm> {
  final _RiderRegistrationFormKey = GlobalKey<FormState>();

  // Registration Controllers to send the data to the IPFS Server
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ethAddressController = TextEditingController();
  final TextEditingController _carRegnController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _carMakeController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();

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
                                  ))))),
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
                                  controller: _ethAddressController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.badge),
                                    border: InputBorder.none,
                                    labelText: 'Ethereum Address',
                                  ))))),
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
                                  controller: _phoneNumberController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    border: InputBorder.none,
                                    labelText: 'Contact No.',
                                  ))))),
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
                                  controller: _carRegnController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.smartphone),
                                    border: InputBorder.none,
                                    labelText: 'Car Registration No.',
                                  ))))),
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
                                  controller: _carMakeController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.vpn_key),
                                    border: InputBorder.none,
                                    labelText: 'Car Make',
                                  ))))),
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
                                  controller: _carModelController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.add_location),
                                    border: InputBorder.none,
                                    labelText: 'Car Model',
                                  ))))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 25.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            await OrbitDBConnector().addDriver(
                                _ethAddressController.text,
                                _nameController.text,
                                _phoneNumberController.text,
                                _carRegnController.text,
                                _carMakeController.text,
                                _carModelController.text);
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            String publicEthKey = _ethAddressController.text;
                            await prefs.setString(
                                'driverPublicKey', publicEthKey);

                            Navigator.pushNamed(context, '/drivermain');
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
