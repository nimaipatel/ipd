import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:ipd_app/pages/conf_trial.dart';

class BookRide extends StatefulWidget {
  const BookRide({Key? key}) : super(key: key);

  @override
  _BookRideState createState() => _BookRideState();
}

class _BookRideState extends State<BookRide> {
  bool visibleCont = true;
  bool visibleText = false;
  bool visibleTopMenu = true;
  String buttonText = "Book Now!";

  void toggleState() {
    setState(() {
      visibleText = !visibleText;
      buttonText = "Check Availability";
    });
  }

  void removeTopMenu() {
    setState(() {
      visibleTopMenu = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Ride'),
          centerTitle: true,
        ),
        body: Container(
            color: Colors.grey,
            child: Stack(children: [
              Column(
                children: [
                  Visibility(
                      visible: visibleTopMenu,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0))),
                        height: 200.0,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 15.0, 15.0, 7.5),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: TextFormField(
                                            decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Source',
                                        ))))),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 7.5, 15.0, 15.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: TextFormField(
                                            decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Source',
                                        ))))),
                            Visibility(
                                visible: visibleText,
                                child: const Text("Estd Time")),
                            Visibility(
                                visible: visibleText,
                                child: const Text("Estd Cost")),
                          ],
                        ),
                      )),
                  Container(
                    color: Colors.grey,
                  )
                ],
              ),
              Visibility(
                  visible: !visibleTopMenu,
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .60,
                        right: 20.0,
                        left: 20.0),
                    child: Container(
                      height: 250.0,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15.0),
                                child: Card(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 15.0),
                                        height: 75.0,
                                        width: 75.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20.0),
                                        child: Column(
                                          children: [
                                            const Text("Line1"),
                                            const Text("Line2"),
                                            const Text("Line3")
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 25.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .30,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: const Text('Cancel'),
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)))),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 25.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .30,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: const Text('Call'),
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)))),
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .40,
                                  child: TextField(
                                      decoration: const InputDecoration(
                                    labelText: 'Source',
                                  )),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .40,
                                  child: TextField(
                                      decoration: const InputDecoration(
                                    labelText: 'Source',
                                  )),
                                )
                              ],
                            )
                          ],
                        ),
                        color: Colors.white,
                        elevation: 4.0,
                      ),
                    ),
                  ))
            ])),
        floatingActionButton: !visibleText
            ? Visibility(
                child: FloatingActionButton.extended(
                    onPressed: () {
                      toggleState();
                    },
                    label: Text(buttonText),
                    icon: const Icon(Icons.car_rental)))
            : Visibility(
                visible: visibleTopMenu,
                child: FloatingActionButton.extended(
                    onPressed: () {
                      removeTopMenu();
                      //showModalBottomSheet(
                      //context: context,
                      //barrierColor: Colors.transparent,
                      //builder: (context) {
                      //  return ConfTrial();
                      //});
                    },
                    label: Text(buttonText),
                    icon: const Icon(Icons.car_rental)),
              ));
  }
}
