import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/bid.dart';
import 'package:flutter_ecommerce/model/product.dart';
import 'package:flutter_ecommerce/services/firestore_bids_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpgradeBidPage extends StatefulWidget {
  Bid _bid;
  Product _product;

  UpgradeBidPage(this._product, this._bid);

  _UpgradeBidPageState createState() => _UpgradeBidPageState();
}

class _UpgradeBidPageState extends State<UpgradeBidPage>
    with TickerProviderStateMixin {
  String price_value = "0.00";
  FirebaseFirestoreServiceBids db = FirebaseFirestoreServiceBids();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    price_value = widget._bid.amount;
  }

  doMakeBid() {
    widget._bid.setStatus("created");
    // widget._bid.setPrice(price_value);
    db.updateBid(widget._bid).then((result) {
      Fluttertoast.showToast(
        msg: "Success!",
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
    });
    Navigator.of(context).pop();
  }

  doCancelBid() {
    widget._bid.setStatus("canceled");
    db.updateBid(widget._bid).then((result) {
      Fluttertoast.showToast(
        msg: "Success!",
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
    });
    Navigator.of(context).pop();
  }

  void _showConfirmDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Are you sure?"),
          content: new Text("Your total price is ."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                doMakeBid();
              },
            ),
          ],
        );
      },
    );
  }

  void _cancelConfirmDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Are you sure?"),
          content: new Text("This bid will be canceled."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                doCancelBid();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          alignment: Alignment.centerLeft,
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: _cancelConfirmDialog,
          )
        ],
        title: Container(
          child: Column(
            children: <Widget>[
              Text(
                '\$' + widget._product.price,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Text(
                'Asking price',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text(''),
          Text(
            'Last Bid: \$' + widget._bid.amount,
            style: TextStyle(fontSize: 25, color: Colors.grey),
          ),
          Text(
            widget._bid.status,
            style: TextStyle(fontSize: 15, color: Colors.red),
          ),
          Divider(),
          Text(
            price_value,
            style: TextStyle(fontSize: 50, color: Colors.black),
          ),
          Text(
            'New offer',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          Divider(),
          //  Hero(tag: widget._product.id,),
          new Expanded(
            child: new Container(
              margin: EdgeInsets.only(
                left: 10.0,
                right: 10,
              ),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      color: Color(0Xffdb3236),
                      onPressed: () {},
                      child: new Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                              child: new FlatButton(
                                onPressed: _showConfirmDialog,
                                padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                ),
                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "Make your bid",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
      bottomNavigationBar: Container(
        height: 320,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      highlightedBorderColor: Colors.black,
                      borderSide: BorderSide(width: 1.0),
                      onPressed: () {
                        setState(() {
                          if (price_value == '0') price_value = '';
                          if (price_value.length > 10) {
                            Fluttertoast.showToast(
                              msg: "The price value's lenght is too long.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            return;
                          }
                          price_value = price_value + '1';
                        });
                      },
                      child: Text(
                        "1",
                        style: TextStyle(fontSize: 40, height: 1.7),
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: OutlineButton(
                      highlightedBorderColor: Colors.black,
                      borderSide: BorderSide(width: 1.0),
                      onPressed: () {
                        setState(() {
                          if (price_value == '0') price_value = '';
                          if (price_value.length > 10) {
                            Fluttertoast.showToast(
                              msg: "The price value's lenght is too long.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            return;
                          }
                          price_value = price_value + '2';
                        });
                      },
                      child: Text(
                        "2",
                        style: TextStyle(fontSize: 40, height: 1.7),
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: OutlineButton(
                      highlightedBorderColor: Colors.black,
                      borderSide: BorderSide(width: 1.0),
                      onPressed: () {
                        setState(() {
                          if (price_value == '0') price_value = '';
                          if (price_value.length > 10) {
                            Fluttertoast.showToast(
                              msg: "The price value's lenght is too long.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            return;
                          }
                          price_value = price_value + '3';
                        });
                      },
                      child: Text(
                        "3",
                        style: TextStyle(fontSize: 40, height: 1.7),
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      borderSide: BorderSide(width: 1.0),
                      highlightedBorderColor: Colors.black,
                      onPressed: () {
                        setState(() {
                          if (price_value == '0') price_value = '';
                          if (price_value.length > 10) {
                            Fluttertoast.showToast(
                              msg: "The price value's lenght is too long.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            return;
                          }
                          price_value = price_value + '4';
                        });
                      },
                      child: Text(
                        "4",
                        style: TextStyle(fontSize: 40, height: 1.7),
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: OutlineButton(
                      highlightedBorderColor: Colors.black,
                      borderSide: BorderSide(width: 1.0),
                      onPressed: () {
                        setState(() {
                          if (price_value == '0') price_value = '';
                          if (price_value.length > 10) {
                            Fluttertoast.showToast(
                              msg: "The price value's lenght is too long.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            return;
                          }
                          price_value = price_value + '5';
                        });
                      },
                      child: Text(
                        "5",
                        style: TextStyle(fontSize: 40, height: 1.7),
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: OutlineButton(
                      highlightedBorderColor: Colors.black,
                      borderSide: BorderSide(width: 1.0),
                      onPressed: () {
                        setState(() {
                          if (price_value == '0') price_value = '';
                          if (price_value.length > 10) {
                            Fluttertoast.showToast(
                              msg: "The price value's lenght is too long.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            return;
                          }
                          price_value = price_value + '6';
                        });
                      },
                      child: Text(
                        "6",
                        style: TextStyle(fontSize: 40, height: 1.7),
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      highlightedBorderColor: Colors.black,
                      borderSide: BorderSide(width: 1.0),
                      onPressed: () {
                        setState(() {
                          if (price_value == '0') price_value = '';
                          if (price_value.length > 10) {
                            Fluttertoast.showToast(
                              msg: "The price value's lenght is too long.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            return;
                          }
                          price_value = price_value + '7';
                        });
                      },
                      child: Text(
                        "7",
                        style: TextStyle(fontSize: 40, height: 1.7),
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: OutlineButton(
                      highlightedBorderColor: Colors.black,
                      borderSide: BorderSide(width: 1.0),
                      onPressed: () {
                        setState(() {
                          if (price_value == '0') price_value = '';
                          if (price_value.length > 10) {
                            Fluttertoast.showToast(
                              msg: "The price value's lenght is too long.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            return;
                          }
                          price_value = price_value + '8';
                        });
                      },
                      child: Text(
                        "8",
                        style: TextStyle(fontSize: 40, height: 1.7),
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: OutlineButton(
                      highlightedBorderColor: Colors.black,
                      borderSide: BorderSide(width: 1.0),
                      onPressed: () {
                        setState(() {
                          if (price_value == '0') price_value = '';
                          if (price_value.length > 10) {
                            Fluttertoast.showToast(
                              msg: "The price value's lenght is too long.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            return;
                          }
                          price_value = price_value + '9';
                        });
                      },
                      child: Text(
                        "9",
                        style: TextStyle(fontSize: 40, height: 1.7),
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      highlightedBorderColor: Colors.black,
                      borderSide: BorderSide(width: 1.0),
                      onPressed: () {
                        setState(() {
                          if (price_value.length > 10) {
                            Fluttertoast.showToast(
                              msg: "The price value's lenght is too long.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            return;
                          }
                          if (price_value.contains('.')) return;
                          price_value = price_value + '.';
                        });
                      },
                      child: Text(
                        ".",
                        style: TextStyle(fontSize: 40, height: 1.7),
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: OutlineButton(
                      highlightedBorderColor: Colors.black,
                      borderSide: BorderSide(width: 1.0),
                      onPressed: () {
                        setState(() {
                          if (price_value == '0') price_value = '';
                          if (price_value.length > 10) {
                            Fluttertoast.showToast(
                              msg: "The price value's lenght is too long.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            return;
                          }
                          price_value = price_value + '0';
                        });
                      },
                      child: Text(
                        "0",
                        style: TextStyle(fontSize: 40, height: 1.7),
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: OutlineButton(
                      highlightedBorderColor: Colors.black,
                      borderSide: BorderSide(width: 1.0),
                      onPressed: () {
                        setState(() {
                          price_value =
                              price_value.substring(0, price_value.length - 1);
                          if (price_value.length == 0) {
                            price_value = '0';
                          }
                        });
                      },
                      child: Icon(
                        Icons.backspace,
                        size: 80,
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
