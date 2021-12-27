import 'package:flutter/material.dart';
import 'package:blockchain_ridesharing/pages/landing_page.dart';
import 'package:blockchain_ridesharing/pages/rider_signup.dart';
import 'package:blockchain_ridesharing/pages/rider_signin.dart';
import 'package:blockchain_ridesharing/pages/ride_booking.dart';
import 'package:blockchain_ridesharing/pages/map_page.dart';
import 'package:blockchain_ridesharing/contract_linking.dart';
import 'package:provider/provider.dart';
// import 'package:blockchain_ridesharing/pages/conf_trial.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
      create: (_) => ContractLinking(),
      child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/signup': (context) => const RiderRegistrationForm(),
        '/signin': (context) => const RiderLoginForm(),
        '/ridebook': (context) => const BookRide(),
        '/map':(context) => const MapPageWidget()
        //'/confrial': (context) => ConfTrial()
      },
    ),
    );
  }
}
