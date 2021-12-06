import 'package:flutter/material.dart';

class ConfTrial extends StatefulWidget {
  const ConfTrial({Key? key}) : super(key: key);

  @override
  _ConfTrialState createState() => _ConfTrialState();
}

class _ConfTrialState extends State<ConfTrial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 25.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size.fromHeight(50.0)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 25.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Call'),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size.fromHeight(50.0)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)))),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Source',
                  ))),
              Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Destination',
                  )))
            ],
          )
        ],
      ),
    );
  }
}
