import 'package:flutter/material.dart';

class DriverRegnForm extends StatefulWidget {
  const DriverRegnForm({Key? key}) : super(key: key);

  @override
  _DriverRegnFormState createState() => _DriverRegnFormState();
}

class _DriverRegnFormState extends State<DriverRegnForm> {
  final _driverRegnFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController carMakeController = TextEditingController();
    TextEditingController regNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController resAddresssController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Join us as a driver!'),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
                child: Form(
                    child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Enter your name"),
                ),
                TextFormField(
                  controller: carMakeController,
                  decoration: InputDecoration(labelText: "Enter your car make"),
                ),
                TextFormField(
                  controller: regNumberController,
                  decoration: InputDecoration(
                      labelText: "Enter your registration number"),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Enter your email"),
                ),
                TextFormField(
                  controller: resAddresssController,
                  decoration: InputDecoration(
                      labelText: "Enter your residential address"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        nameController.clear();
                        carMakeController.clear();
                        regNumberController.clear();
                        emailController.clear();
                        resAddresssController.clear();
                      },
                      child: Text('Add')),
                )
              ],
            )))));
  }
}
