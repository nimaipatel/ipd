import 'package:flutter/material.dart';

import '../rating_widget.dart';

class RideEnd extends StatefulWidget {
  const RideEnd({Key? key}) : super(key: key);

  @override
  State<RideEnd> createState() => _RideEndState();
}

class _RideEndState extends State<RideEnd> {
  double rating = 3.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Main'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StarRating(
            rating: rating,
            onRatingChanged: (rating) => setState(() => this.rating = rating),
          ),
        ],
      ),
    );
  }
}
