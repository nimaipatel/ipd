import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';

class RiderLoginForm extends StatefulWidget {
  const RiderLoginForm({Key? key}) : super(key: key);

  @override
  _RiderLoginFormState createState() => _RiderLoginFormState();
}

class _RiderLoginFormState extends State<RiderLoginForm> {
  final _riderLoginFormKey = GlobalKey<FormState>();

  // Form Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ethPrivateKeyController =
      TextEditingController();
  final TextEditingController _ethPublicKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RideApp'),
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
                "Let's Sign In To Our App.",
                style: TextStyle(fontSize: 50.0, color: Colors.black),
                textAlign: TextAlign.left,
              ),
            )),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: const EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 141, 203, 240),
                  borderRadius: BorderRadius.circular(20.0)),
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                key: _riderLoginFormKey,
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
                                    prefixIcon: Icon(Icons.email),
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
                                  controller: _ethPrivateKeyController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.vpn_key),
                                    border: InputBorder.none,
                                    labelText: 'Eth Key',
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
                                  controller: _ethPublicKeyController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    border: InputBorder.none,
                                    labelText: 'Public Key',
                                  ))))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 25.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            String privateEthKey =
                                _ethPrivateKeyController.text;
                            String publicEthKey = _ethPublicKeyController.text;

                            await prefs.setString(
                                'driverPrivateKey', privateEthKey);
                            await prefs.setString(
                                'driverPublicKey', publicEthKey);

                            Navigator.pushNamed(context, '/drivermain');
                          },
                          child: const Text('Sign In'),
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
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () async {
      //       final SharedPreferences prefs =
      //           await SharedPreferences.getInstance();
      //
      //       String privateEthKey = _ethPrivateKeyController.text;
      //       String publicEthKey = _ethPublicKeyController.text;
      //
      //       await prefs.setString('driverPrivateKey', privateEthKey);
      //       await prefs.setString('driverPublicKey', publicEthKey);
      //
      //       Navigator.pushNamed(context, '/drivermain');
      //     },
      //     label: const Text("Driver Main Page"),
      //     icon: const Icon(Icons.car_rental)),
    );
  }
}
