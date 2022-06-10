import 'package:blockchain_ridesharing/pages/choose_driver.dart';
import 'package:blockchain_ridesharing/pages/driver_landing_page.dart';
import 'package:blockchain_ridesharing/pages/driver_main.dart';
import 'package:blockchain_ridesharing/pages/driver_signup.dart';
import 'package:blockchain_ridesharing/pages/ride_ended.dart';
import 'package:blockchain_ridesharing/pages/rider_landing_page.dart';
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

        '/driver': (context) => const DriverLandingPage(),
        '/driverMain': (context) => const DriverMainPage(),
        '/driverSignUp': (context) => const DriverRegistrationForm(),
        '/driverSignIn': (context) => const RiderLoginForm(),

        '/rider': (context) => const RiderLandingPage(),
        '/riderSignUp': (context) => const RiderRegistrationForm(),
        '/riderSignIn': (context) => const RiderLoginForm(),
        '/riderBook': (context) => const BookRide(),

        '/map':(context) => const MapPageWidget(),
        '/rating' : (context) => const RideEnd()
      },
    ),
    );
  }
}
