import 'package:flutter/material.dart';

class RiderLoginForm extends StatefulWidget {
  const RiderLoginForm({Key? key}) : super(key: key);

  @override
  _RiderLoginFormState createState() => _RiderLoginFormState();
}

class _RiderLoginFormState extends State<RiderLoginForm> {
  final _RiderLoginFormKey = GlobalKey<FormState>();

  // Form Controllers
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

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
              "Let's Sign In To Our App.",
              style: TextStyle(fontSize: 45.0, color: Colors.black),
              textAlign: TextAlign.center,
            )),
            Container(
              color: Colors.grey,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: const EdgeInsets.only(top: 10.0),
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                key: _RiderLoginFormKey,
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
                                controller: _emailController,
                                  decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Email ID',
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
                                border: InputBorder.none,
                                labelText: 'Password',
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
                          child: const Text('Sign In'),
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
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/ridebook');
          },
          label: const Text("Ride Book Page"),
          icon: const Icon(Icons.car_rental)),
    );
  }
}
