import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask.dart';
import 'package:flutter_ecommerce/model/ask_product.dart';
import 'package:flutter_ecommerce/model/bid.dart';
import 'package:flutter_ecommerce/screen/supplier/asks/bid_product_page.dart';
import 'package:flutter_ecommerce/services/firestore_ask_products_service.dart';
import 'package:flutter_ecommerce/services/firestore_bids_service.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

import 'bid_selectable_list_fragment.dart';

class AskViewPage extends StatefulWidget {
  Ask ask;

  AskViewPage({this.ask});

  _AskViewPageState createState() => _AskViewPageState();
}

class _AskViewPageState extends State<AskViewPage>
    with TickerProviderStateMixin {
  FirebaseFirestoreServiceAskProducts db =
      FirebaseFirestoreServiceAskProducts();

  AnimationController _controller;
  final GlobalKey _globalKey = new GlobalKey(debugLabel: 'Products');

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 500),
      value: 0.0,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.search, color: Colors.grey,), onPressed: (){},),
        //   IconButton(icon: Icon(Icons.shopping_basket, color: Colors.grey,), onPressed: (){},),
        // ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Ask Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: _buildPageContent(),
    );
  }

  Widget _buildPageContent() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.ask.ask_title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Text("Budget: ${}", style: TextStyle(
                //       color: Colors.red,
                //       fontSize: 18.0,
                //       fontWeight: FontWeight.w600
                //     ),)
                //   ],
                // ),
                // SizedBox(height: 10.0,),
                Text(
                  widget.ask.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  DateFormat.yMMMd().format(DateTime.parse(
                                widget.ask.updated_date
                                .replaceAll(' ', 'T')
                                .replaceAll(':', '')
                                .replaceAll('-', ''))),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Ask Products",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text("See All",
                          style: TextStyle(color: Colors.grey.shade500)),
                    ],
                  ),
                ),

                _buildItemsGrid()
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // _buildBidNowButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildItemsGrid() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      height: 250,
      child: StreamBuilder<QuerySnapshot>(
        stream: db.getAskProcutsListByaID(widget.ask.id),
        builder: (ctx, snap) {
          if (snap.hasError) {
            return Text('Error: ${snap.error}');
          }
          switch (snap.connectionState) {
            case ConnectionState.waiting:
              return const Text('Loading...');
            default:
              if (snap.data.documents.isEmpty) {
                return const SizedBox(
                  height: 20,
                );
              }
              return new ListView.builder(
                itemCount: snap.data.documents.length,
                itemBuilder: (_, index) => _buildProductItem(
                    context, AskProduct.map(snap.data.documents[index])),
              );
          }
        },
      ),
    );
  }

  Widget _buildBidNowButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              onPressed: () {},
              child: Text("Bid Now"),
              color: Colors.orange,
              textColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductItem(BuildContext context, AskProduct data) {
    FirebaseFirestoreServiceBids dbd = FirebaseFirestoreServiceBids();

    return StreamBuilder<QuerySnapshot>(
        stream: dbd.getBidByUandPid(Util.uid, data.id),
        builder: (ctx, snap) {
          if (snap.hasError) {
            return Text('Error: ${snap.error}');
          }
          switch (snap.connectionState) {
            case ConnectionState.waiting:
              return new Card(
                child: ListTile(
                  title: Text('Loading...'),
                ),
              );
            default:
              if (snap.data.documents.isEmpty) {
                return new Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    title: Text(data.product_name),
                    onTap: () => _showinfoDialog(data),
                  ),
                );
              }
              return new Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  title: Text(data.product_name),
                  onTap: () => _showinfoDialog(data,
                      bid: Bid.map(snap.data.documents[0])),
                  subtitle: Text(
                      "Bid status: ${Bid.map(snap.data.documents[0]).status}"),
                ),
              );
          }
        });
  }

  void _showinfoDialog(AskProduct data, {bid}) {
    Bid _bid = bid;
    // flutter defined function
    Alert(
      context: context,
      title: data.product_name,
      content: SizedBox(
        width: 400,
        height: 400.0,
        child: new ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: _bid != null
              ? <Widget>[
                  new Text("About Ask", style: TextStyle(fontSize: 20)),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text("Budget: \$${data.budget}",
                      style: TextStyle(fontSize: 20)),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text(
                    "Quantity: ${data.quantity}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text("Specification: "),
                  new Text(
                    data.specifications,
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text(
                    "Description: ",
                  ),
                  new Text(
                    data.description,
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text(
                    
                      "Delivery Date: ${DateFormat.yMMMd().format(DateTime.parse(data.delivery_date.split(" ")[0].replaceAll(' ', 'T').replaceAll(':', '').replaceAll('-', '')))}"),
                  Divider(
                    color: Colors.grey,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text("About Bid", style: TextStyle(fontSize: 20)),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text("Bid Title: "),
                  new Text(
                    _bid.bid_title,
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text("Bid Quantity: "),
                  new Text(
                    _bid.quantity,
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text("Bid Amount: "),
                  new Text(
                    _bid.amount,
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text("Bid Created Date: "),
                  new Text(
                    DateFormat.yMMMd().format(DateTime.parse(_bid.updated_date.split(" ")[0].replaceAll(' ', 'T').replaceAll(':', '').replaceAll('-', ''))),
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                ]
              : <Widget>[
                  new Text("About Ask", style: TextStyle(fontSize: 20)),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text("Budget: \$${data.budget}",
                      style: TextStyle(fontSize: 20)),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text(
                    "Quantity: ${data.quantity}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text("Specification: "),
                  new Text(
                    data.specifications,
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text(
                    "Description: ",
                  ),
                  new Text(
                    data.description,
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  new Text(
                      "Delivery Date: ${DateFormat.yMMMd().format(DateTime.parse(data.delivery_date.split(" ")[0].replaceAll(' ', 'T').replaceAll(':', '').replaceAll('-', '')))}"),
                  Divider(
                    color: Colors.grey,
                  ),
                ],
        ),
      ),
      buttons: <DialogButton>[
        // usually buttons at the bottom of the dialog
        DialogButton(
          // radius: BorderRadius.circular(40.0),
          onPressed: () {
            Navigator.pop(context);
            _bid == null
                ? Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BidSelectableListFragment(data)))
                : Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => BidProductPage(
                          data,
                          bid: _bid,
                        )));
            // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => BidSelectableListFragment(data)));
          },
          child: _bid == null
              ? Text(
                  "Bid Now",
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  'Update Bid',
                  style: TextStyle(color: Colors.white),
                ),
          color: Colors.orange,
        ),
        new DialogButton(
          child: new Text(
            "Close",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.red,
        ),
      ],
    ).show();
  }
}
