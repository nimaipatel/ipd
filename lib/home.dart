import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:decen_ridesharing/contract_linking.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    TextEditingController nameController = TextEditingController();
    TextEditingController carMakeController = TextEditingController();
    TextEditingController regNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController resAddresssController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text('Join us as a driver!'),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: contractLink.isLoading
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                    child: Form(
                        child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration:
                            InputDecoration(labelText: "Enter your name"),
                      ),
                      TextFormField(
                        controller: carMakeController,
                        decoration:
                            InputDecoration(labelText: "Enter your car make"),
                      ),
                      TextFormField(
                        controller: regNumberController,
                        decoration: InputDecoration(
                            labelText: "Enter your registration number"),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration:
                            InputDecoration(labelText: "Enter your email"),
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
                              contractLink.addNewDriver(
                                  nameController.text,
                                  carMakeController.text,
                                  regNumberController.text,
                                  emailController.text,
                                  resAddresssController.text);
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
