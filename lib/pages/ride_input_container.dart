import 'package:flutter/material.dart';

class RideInputContainer extends StatefulWidget {
  const RideInputContainer({Key? key}) : super(key: key);

  @override
  _RideInputContainerState createState() => _RideInputContainerState();
}

class _RideInputContainerState extends State<RideInputContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0))),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 7.5),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextFormField(
                          decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Source',
                      ))))),
          Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 7.5, 15.0, 15.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextFormField(
                          decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Source',
                      ))))),
          Visibility(visible: true, child: const Text("Estd Time")),
          Visibility(visible: true, child: const Text("Estd Cost")),
        ],
      ),
    );
  }
}
