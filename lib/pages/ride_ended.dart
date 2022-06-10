import 'package:flutter/material.dart';

import '../rating_widget.dart';

class RideEnd extends StatefulWidget {
  const RideEnd({Key? key}) : super(key: key);

  @override
  State<RideEnd> createState() => _RideEndState();
}

class _RideEndState extends State<RideEnd> {
  double rating = 0;
  bool ratingDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookRide'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: Text(
                "Rate your ride!",
                style: TextStyle(fontSize: 50.0, color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          !ratingDone
              ? Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 110.0),
                    child: StarRating(
                      rating: rating,
                      onRatingChanged: (rating) => {
                        setState(() => this.rating = rating),
                      },
                    ),
                  )),
                )
              : const Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                    child: Text(
                      "Thanks for rating us!",
                      style: TextStyle(fontSize: 30.0, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              !ratingDone ?
              setState(() {
                ratingDone = true;
              }) :
              Navigator.popUntil(context, ModalRoute.withName('/'));

            },
            child: !ratingDone ? const Text('Submit'): const Text('Done'),
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                    const Size.fromHeight(50.0)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)))),
          ),
        ],
      ),
    );
  }
}
