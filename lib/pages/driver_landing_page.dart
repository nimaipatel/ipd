import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DriverLandingPage extends StatelessWidget {
  const DriverLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 141, 203, 240),
      body:Padding(
        padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              child: const Text('Sign In'),
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                      const Size.fromHeight(50.0)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)))),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Sign Up!'),
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                      const Size.fromHeight(50.0)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)))),
            ),
          ],
        ),
      )
    );
  }
}
