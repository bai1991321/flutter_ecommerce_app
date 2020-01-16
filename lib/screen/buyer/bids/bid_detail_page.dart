import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask_product.dart';
import 'package:flutter_ecommerce/model/bid.dart';
import 'package:flutter_ecommerce/model/product.dart';
import 'package:flutter_ecommerce/screen/buyer/checkout/delivery_screen.dart';
import 'package:flutter_ecommerce/services/firestore_bids_service.dart';
import 'package:flutter_ecommerce/services/firestore_product_service.dart';
import 'package:flutter_ecommerce/utils/data.dart';

class BidDetailPageForAsk extends StatefulWidget {
  final Bid _bid;
  final AskProduct _product;

  BidDetailPageForAsk(this._bid, this._product);

  _BidDetailPageForAskState createState() => _BidDetailPageForAskState();
}

class _BidDetailPageForAskState extends State<BidDetailPageForAsk> {
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

  @override
  Widget build(BuildContext context) {
    Bid bid = widget._bid;
    return Scaffold(
      appBar: AppBar(
        title: Text("Bid Detail"),
        backgroundColor: Colors.amber[800],
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
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          'Product Name',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.body2,
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
                          'First Price: \$' + widget._product.budget,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        // color: beer.color.withAlpha(120),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  right: 15.0, left: 15.0, top: 15.0),
                              child: Text(
                                'Bid price',
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .body2
                                    .copyWith(
                                        color:
                                            int.parse(widget._product.budget) >
                                                    int.parse(bid.amount)
                                                ? Colors.red
                                                : Colors.black),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: 15.0, right: 15.0, bottom: 15.0),
                              child: Text(
                                '\$' + bid.amount,
                                style: TextStyle(
                                    color: int.parse(widget._product.budget) >
                                            int.parse(bid.amount)
                                        ? Colors.red
                                        : Colors.black),
                              ),
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
                color: Colors.redAccent,
                onPressed: _clickPayNow,
                child: Text(
                  'Accept and Pay now',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  _clickPayNow() async {
    FirebaseFirestoreServiceProduct pdb = FirebaseFirestoreServiceProduct();
    Product product = await pdb
        .getProductByID(widget._bid.supportProductId)
        .map((convert) => Product.map(convert))
        .first;
    cart buyitem = cart(int.parse(widget._product.quantity), product);
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => Deliveryfragment([buyitem])));
  }
}
