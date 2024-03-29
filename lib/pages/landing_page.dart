import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 141, 203, 240),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset('assets/logo.png'),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 60.0),
              child: Center(
                  child: Text(
                "RideApp",
                style: TextStyle(fontSize: 50.0, color: Colors.black),
                textAlign: TextAlign.left,
              )),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ridebook');
              },
              child: const Text('Ride with us!'),
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                      const Size.fromHeight(50.0)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)))),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/driver');
              },
              child: const Text('Drive with us!'),
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                      const Size.fromHeight(50.0)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)))),
            ),
          ],
        ),
      ),
    );
  }
}
