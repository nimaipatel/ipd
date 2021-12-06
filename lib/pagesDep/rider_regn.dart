import 'package:flutter/material.dart';

class RiderRegnForm extends StatefulWidget {
  const RiderRegnForm({Key? key}) : super(key: key);

  @override
  _RiderRegnFormState createState() => _RiderRegnFormState();
}

class _RiderRegnFormState extends State<RiderRegnForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //final _riderRegnFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passengersController = TextEditingController();
    TextEditingController contactNoController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController resAddresssController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Join us as a rider!'),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
                child: Form(
                    child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(labelText: "Enter your name"),
                ),
                TextFormField(
                  controller: passengersController,
                  decoration: const InputDecoration(
                      labelText: "Enter number of passengers"),
                ),
                TextFormField(
                  controller: contactNoController,
                  decoration: const InputDecoration(
                      labelText: "Enter your contact number"),
                ),
                TextFormField(
                  controller: emailController,
                  decoration:
                      const InputDecoration(labelText: "Enter your email"),
                ),
                TextFormField(
                  controller: resAddresssController,
                  decoration: const InputDecoration(
                      labelText: "Enter your residential address"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        nameController.clear();
                        passengersController.clear();
                        contactNoController.clear();
                        emailController.clear();
                        resAddresssController.clear();
                      },
                      child: const Text('Add')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/driver');
                      },
                      child: const Text('Driver Page')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/list');
                      },
                      child: const Text('List')),
                )
              ],
            )))));
  }
}
