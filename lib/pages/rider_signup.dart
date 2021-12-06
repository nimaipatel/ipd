import 'package:flutter/material.dart';

class RiderRegistrationForm extends StatefulWidget {
  const RiderRegistrationForm({Key? key}) : super(key: key);

  @override
  _RiderRegistrationFormState createState() => _RiderRegistrationFormState();
}

class _RiderRegistrationFormState extends State<RiderRegistrationForm> {
  final _RiderRegistrationFormKey = GlobalKey<FormState>();
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
                child: Text(
              "Let's Start By Creating Your Account.",
              style: TextStyle(fontSize: 45.0, color: Colors.black),
              textAlign: TextAlign.center,
            )),
            Container(
              color: Colors.grey,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: EdgeInsets.only(top: 10.0),
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
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TextFormField(
                                  decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'First Name',
                              ))))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TextFormField(
                                  decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Last Name',
                              ))))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TextFormField(
                                  decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Email Address',
                              ))))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TextFormField(
                                  decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Phone Number',
                              ))))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TextFormField(
                                  decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Password',
                              ))))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TextFormField(
                                  decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'City',
                              ))))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TextFormField(
                                  decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'State',
                              ))))),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TextFormField(
                                  decoration: const InputDecoration(
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
                                      borderRadius: BorderRadius.circular(0)))),
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
