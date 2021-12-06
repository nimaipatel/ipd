

import 'package:flutter/material.dart';
import 'package:blockchain_ridesharing/pages/landing_page.dart';
import 'package:blockchain_ridesharing/pages/rider_signup.dart';
import 'package:blockchain_ridesharing/pages/rider_signin.dart';
import 'package:blockchain_ridesharing/pages/ride_booking.dart';
import 'package:blockchain_ridesharing/pages/conf_trial.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/signup': (context) => RiderRegistrationForm(),
        '/signin': (context) => RiderLoginForm(),
        '/ridebook': (context) => BookRide(),
        //'/confrial': (context) => ConfTrial()
      },
    ));
