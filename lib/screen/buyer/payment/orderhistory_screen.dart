// import 'package:f_groceries/Cart_Screen.dart';
// import 'package:f_groceries/item_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utils/util.dart';
// import 'package:flutter_range_slider/flutter_range_slider.dart';

class Oder_History extends StatefulWidget {
  final String toolbarname;

  Oder_History({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => oder_history(toolbarname);
}

class oder_history extends State<Oder_History> {
  List list = ['12', '11'];
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  VoidCallback _showBottomSheetCallback;

  // String toolbarname = 'Fruiys & Vegetables';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  oder_history(this.toolbarname);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    IconData _backIcon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_back;
        case TargetPlatform.iOS:
          return Icons.arrow_back_ios;
      }
      assert(false);
      return null;
    }

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(_backIcon()),
            alignment: Alignment.centerLeft,
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Payment History"),
          backgroundColor: Colors.amber,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('stripe')
                .document(Util.uid)
                .collection("charges")
                .snapshots(),
            builder: (context, snap) {
              switch (snap.connectionState) {
                case ConnectionState.waiting:
                  return new Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (!snap.hasData) {
                    return Center(
                      child: Text(
                        "There is no Payments",
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snap.data.documents.length,
                      itemBuilder: (BuildContext cont, int ind) {
                        Map<String, dynamic> item =
                            snap.data.documents[ind].data;
                        return SafeArea(
                            child: Column(children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                  left: 5.0, right: 5.0, bottom: 5.0),
                              color: Colors.black12,
                              child: Card(
                                  elevation: 4.0,
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 10.0, 10.0, 10.0),
                                      child: GestureDetector(
                                          child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          // three line description
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              '${item['product']}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(top: 3.0),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Delivery Provider :' +
                                                  '${item['provider']}',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Divider(
                                            height: 10.0,
                                            color: Colors.amber.shade500,
                                          ),

                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        'Tracking Id',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 3.0),
                                                        child: Text(
                                                          '${item['tracking']}',
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 10.0,
                                            color: Colors.amber.shade500,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        'Order Amount',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 3.0),
                                                        child: Text(
                                                          '${item['amount']}',
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        'Shippo fee',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 3.0),
                                                        child: Text(
                                                          '${item['shipfee']}',
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //   MainAxisAlignment.start,
                                          //   children: <Widget>[
                                          //     Icon(
                                          //       Icons.location_on,
                                          //       size: 20.0,
                                          //       color: Colors.amber
                                          //           .shade500,
                                          //     ),
                                          //     Text(
                                          //         itemList[ind].address,
                                          //         style: TextStyle(
                                          //             fontSize: 13.0,
                                          //             color: Colors
                                          //                 .black54)),
                                          //   ],
                                          // ),
                                          // Divider(
                                          //   height: 10.0,
                                          //   color: Colors.amber
                                          //       .shade500,
                                          // ),
                                          // Container(
                                          //     child: _status(
                                          //         itemList[ind]
                                          //             .cancelOder))
                                        ],
                                      ))))),
                        ]));
                      });
              }
            }));
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  Widget _status(status) {
    if (status == 'Cancel Order') {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.red),
          ),
          icon: const Icon(
            Icons.highlight_off,
            size: 18.0,
            color: Colors.red,
          ),
          onPressed: () {
            // Perform some action
          });
    } else {
      return FlatButton.icon(
          label: Text(
            status,
            style: TextStyle(color: Colors.green),
          ),
          icon: const Icon(
            Icons.check_circle,
            size: 18.0,
            color: Colors.green,
          ),
          onPressed: () {
            // Perform some action
          });
    }
    if (status == "3") {
      return Text('Process');
    } else if (status == "1") {
      return Text('Order');
    } else {
      return Text("Waiting");
    }
  }

  erticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Press to show";
      } else {
        a = true;
        mText = "Press to hide";
      }
    });
  }
}
