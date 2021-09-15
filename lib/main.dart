import 'package:decen_ridesharing/contract_linking.dart';
import 'package:decen_ridesharing/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
      create: (_) => ContractLinking(),
      child: MaterialApp(
        title: 'Decentralized Ride Sharing',
        home: Home(),
      ),
    );
  }
}
