import 'package:flutter/material.dart';
import 'package:blockchain_ridesharing/riders.dart';

class AwaitList extends StatefulWidget {
  const AwaitList({Key? key}) : super(key: key);

  @override
  _AwaitListState createState() => _AwaitListState();
}

class _AwaitListState extends State<AwaitList> {
  List<AwaitingRider> riderList = [
    AwaitingRider("Om Naik", 125, "Mumbai", "Pune"),
    AwaitingRider("Nimai Patel", 200, "Pune", "Lonavala")
  ];
  Widget cardTemplate(rider) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                rider.name,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                rider.toLocation,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: riderList.map((rider) => cardTemplate(rider)).toList(),
      ),
    );
  }
}
