import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask.dart';
import 'package:flutter_ecommerce/screen/supplier/asks/asks_view_page.dart';
import 'package:flutter_ecommerce/widgets/animated_fab.dart';
import 'package:flutter_ecommerce/widgets/energy_clipper.dart';
import 'package:intl/intl.dart';

class GeneralCard extends StatefulWidget {
  final Ask ask;

  GeneralCard({this.ask});

  @override
  _GeneralCardState createState() => new _GeneralCardState();
}

class _GeneralCardState extends State<GeneralCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        AskViewPage(ask: widget.ask)));
              },
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Text(DateFormat.yMMMd().format(DateTime.parse(
                                widget.ask.updated_date
                                .replaceAll(' ', 'T')
                                .replaceAll(':', '')
                                .replaceAll('-', ''))),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Status: ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.ask.status,
                                      style: TextStyle(
                                          color: Colors.green.shade800,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${widget.ask.ask_title}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${DateFormat.yMMMd().format(DateTime.parse(widget.ask.updated_date.replaceAll(' ', 'T').replaceAll(':', '').replaceAll('-', '')))}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 75.0,
                    child: ClipPath(
                      clipper: EnergyRateClipper(),
                      child: Container(
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 70.0,
                    child: ClipPath(
                      clipper: EnergyRateClipper(),
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: -110,
                    bottom: 18,
                    child: AnimatedFab(
                      onClick: () => print("clicked"),
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }
}
