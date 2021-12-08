import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Image.asset('assets/logo.jpeg'),
          ),
          const Center(
              child: Text(
            "Ride With AppName",
            style: TextStyle(fontSize: 45.0, color: Colors.white),
            textAlign: TextAlign.center,
          )),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 25.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: const Text('Sign In'),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size.fromHeight(50.0)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)))),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 25.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('Sign Up'),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size.fromHeight(50.0)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)))),
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
