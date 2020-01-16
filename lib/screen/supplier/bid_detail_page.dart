import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask_product.dart';
import 'package:flutter_ecommerce/model/bid.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/screen/chat/chat_screen.dart';
import 'package:flutter_ecommerce/screen/supplier/change_bid_page.dart';
import 'package:flutter_ecommerce/services/firestore_bids_service.dart';
import 'package:flutter_ecommerce/services/firestore_company_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BidDetailPage extends StatefulWidget {
  final Bid _bid;
  final AskProduct _product;

  BidDetailPage(this._bid, this._product);

  _BidDetailPageState createState() => _BidDetailPageState();
}

class _BidDetailPageState extends State<BidDetailPage> {
  bool _visible = false;
  FirebaseFirestoreServiceBids db = FirebaseFirestoreServiceBids();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 250)).then((v) {
      setState(() {
        _visible = true;
      });
    });
    super.initState();
  }

  void _showConfirmDialog() {
    // flutter defined function

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Are you sure?"),
          content: new Text("You have selected"),
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
                widget._bid.setStatus("canceled");
                db.updateBid(widget._bid).then((result) {
                  Fluttertoast.showToast(
                    msg: "Success!",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Bid bid = widget._bid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Product"),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Card(
                elevation: 4.0,
                child: Container(
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // photo and title
                        SizedBox(
                          height: 250.0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              new Container(
                                child: Hero(
                                  tag: widget._bid.buyerID,
                                  child: CachedNetworkImage(
                                    imageUrl: widget._bid.imageURL,
                                    height: 320.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              new Expanded(
                child: SingleChildScrollView(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          'Product name of the ask',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 15.0),
                        child: Text(
                          widget._product.product_name,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          'Company name',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 15.0),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestoreServiceCompany()
                                .getCompanyByID(widget._bid.buyerID),
                            builder: (ctx, snap) {
                              switch (snap.connectionState) {
                                case ConnectionState.waiting:
                                  return Text(
                                    "Loading...",
                                    style: TextStyle(color: Colors.grey),
                                  );
                                default:
                                  Company com =
                                      Company.map(snap.data.documents[0].data);
                                  return Row(
                                    children: <Widget>[
                                      Text(
                                        com.companyName,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.message,
                                          size: 30,
                                        ),
                                        onPressed: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ChatScreen(
                                                            peerId: com.id,
                                                            peerAvatar:
                                                                com.profile))),
                                      )
                                    ],
                                  );
                              }
                            },
                          )),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 15.0),
                        child: Text(
                          widget._product.description,
                        ),
                      ),
                      Divider(
                        height: 10.0,
                        indent: 35.0,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          'Ask price: \$' + widget._product.budget,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 0.0),
                        child: Text(
                          'Bid Price : \$' + bid.amount,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 0.0),
                        child: Text(
                          'Quantity  : ' + bid.quantity,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Text("Count: " + bid.count, style: Theme.of(context).textTheme.body1,),
                            // Text("Total Price: \$" + (int.parse(bid.price)* int.parse(bid.count)).toString(), style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.w500),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 65,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                color: Colors.cyan[400],
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChangeBidPage(widget._bid, widget._product)));
                },
                child: Text(
                  'Modify',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                color: Colors.orange[800],
                onPressed: () {
                  _showConfirmDialog();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Withdraw',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
