import 'package:flutter/material.dart';

class RiderRegistrationForm extends StatefulWidget {
  const RiderRegistrationForm({Key? key}) : super(key: key);

  @override
  _RiderRegistrationFormState createState() => _RiderRegistrationFormState();
}

class _RiderRegistrationFormState extends State<RiderRegistrationForm> {
  final _RiderRegistrationFormKey = GlobalKey<FormState>();

  // Registration Controllers to send the data to the IPFS Server
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

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
                "Let's Sign In To Our App.",
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
                                  controller: _firstNameController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.badge),
                                    border: InputBorder.none,
                                    labelText: 'First Name',
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
                                  controller: _lastNameController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.badge),
                                    border: InputBorder.none,
                                    labelText: 'Last Name',
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
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    border: InputBorder.none,
                                    labelText: 'Email Address',
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
                                    prefixIcon: Icon(Icons.smartphone),
                                    border: InputBorder.none,
                                    labelText: 'Phone Number',
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
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.vpn_key),
                                    border: InputBorder.none,
                                    labelText: 'Password',
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
                                  controller: _cityController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.add_location),
                                    border: InputBorder.none,
                                    labelText: 'City',
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
                                  controller: _stateController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.add_location),
                                    border: InputBorder.none,
                                    labelText: 'State',
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
                                  controller: _countryController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.add_location),
                                    border: InputBorder.none,
                                    labelText: 'Country',
                                  ))))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 25.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: const Text('Register'),
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all<Size>(
                                  const Size.fromHeight(50.0)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.0)))),
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
