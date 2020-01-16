import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/model/product.dart';
import 'package:flutter_ecommerce/screen/buyer/product_bid_page.dart';
import 'package:flutter_ecommerce/services/firestore_bids_service.dart';
import 'package:flutter_ecommerce/services/firestore_company_service.dart';
import 'package:flutter_ecommerce/utils/data.dart';
import 'package:flutter_ecommerce/widgets/stepper_touch.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'checkout/delivery_screen.dart';
import 'discover_screen.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  ProductPage(this.product);

  FirebaseFirestoreServiceBids db = FirebaseFirestoreServiceBids();

  @override
  ProductPageState createState() {
    return new ProductPageState();
  }
}

class ProductPageState extends State<ProductPage>
    with TickerProviderStateMixin {
  GlobalKey stepperKey = GlobalKey();
  AnimationController _controller;
  int count_value = 1;
  Animation<Offset> _drawerDetailsPosition;
  static final Animatable<Offset> _drawerDetailsTween = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).chain(CurveTween(
    curve: Curves.fastOutSlowIn,
  ));

  void toggle() {
    setState(() {
      DiscoverScreen.wishList.products.contains(widget.product)
          ? DiscoverScreen.wishList.products.remove(widget.product)
          : DiscoverScreen.wishList.products.add(widget.product);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  Future<String> onClickBidNow() async {
    // if(count_value>0){

    //   widget.db.createBid("${new Random().nextInt(10000)}${new Random().nextInt(10000)}${new Random().nextInt(10000)}${new Random().nextInt(10000)}",
    //                 Util.uid, widget.product.id, widget.product.supplier, count_value.toString(), widget.product.price, "created").then((result){
    //                       Fluttertoast.showToast(msg: "Success!",toastLength: Toast.LENGTH_SHORT,);
    //                       Navigator.pop(context);
    //                     });
    // }else
    //   Fluttertoast.showToast(msg: "Error zero based.", toastLength: Toast.LENGTH_SHORT,);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ProductBidPage(widget.product, count_value.toString())));
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestoreServiceCompany cdb = FirebaseFirestoreServiceCompany();
    final ThemeData theme = Theme.of(context);
    final TextStyle descriptionStyle = theme.textTheme.subhead;
    final key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            alignment: Alignment.centerLeft,
            tooltip: 'Back',
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Product details",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.amber,
          actions: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Container(
                height: 150.0,
                width: 30.0,
                child: new GestureDetector(
                  onTap: () {
                    /*Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder:(BuildContext context) =>
                      new CartItemsScreen()
                  )
              );*/
                  },
                ),
              ),
            )
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Card(
                elevation: 4.0,
                child: Container(
                  // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30.0)),color: Colors.transparent),
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
                                  tag: "product_${widget.product.id}L",
                                  child: CachedNetworkImage(
                                    imageUrl: widget.product.imageUrl[0],
                                    height: 320.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16.0, bottom: 20.0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        size: 35.0,
                                      ),
                                      color: DiscoverScreen.wishList.products
                                              .contains(widget.product)
                                          ? Colors.redAccent
                                          : Colors.white,
                                      onPressed: () => toggle(),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: DefaultTextStyle(
                      style: descriptionStyle,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // three line description
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              widget.product.itemname,
                              style: descriptionStyle.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "\$" + widget.product.price,
                              style: descriptionStyle.copyWith(
                                fontSize: 25.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ))),
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Card(
                      child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                          child: DefaultTextStyle(
                              style: descriptionStyle,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // three line description
                                  Row(children: <Widget>[
                                    StepperTouch(
                                      key: stepperKey,
                                      initialValue: count_value,
                                      direction: Axis.horizontal,
                                      withSpring: false,
                                      onChanged: (int value) {
                                        setState(() {
                                          count_value = value;
                                        });
                                      },
                                    ),
                                  ]),
                                ],
                              ))))),
              Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: DefaultTextStyle(
                      style: descriptionStyle,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // three line description
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Details',
                              style: descriptionStyle.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                        ],
                      ))),
              Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                  child: Text(widget.product.description,
                      maxLines: 10,
                      style: TextStyle(fontSize: 13.0, color: Colors.black38))),
              Divider(
                height: 5,
              ),
              ListTile(
                title: Text('Company Name:'),
                trailing: StreamBuilder<QuerySnapshot>(
                  stream: cdb.getCompanyByID(widget.product.supplier),
                  builder: (context, snap) {
                    switch (snap.connectionState) {
                      case ConnectionState.waiting:
                        return Text('loading...');
                      default:
                        return Text(
                          Company.fromMap(snap.data.documents.first.data)
                              .companyName,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        );
                    }
                  },
                ),
              ),
            ]))),
        bottomNavigationBar: Container(
            height: 65,
            margin: EdgeInsets.only(left: 15.0, right: 15, bottom: 5),
            child: Row(
              children: <Widget>[
                // FlatButton(
                //   color: Theme.of(context).primaryColor,
                //   onPressed: onClickBidNow,
                // onPressed: () {
                //   HomeScreen.shoppingBasket.addProductToBasket(widget.product.id, 1);
                //   key.currentState.showSnackBar(new SnackBar(
                //     content: new Text(
                //         "${widget.product.itemname} has been added to your basket"),
                //   ));
                // },
                //   padding: EdgeInsets.all( 20.0),
                //   child: Center(
                //     child: Text(
                //       "Order Now",
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: MaterialButton(
                    color: Colors.amber,
                    elevation: 0,
                    onPressed: () {
                      // widget.product.
                      if (count_value > 0) {
                        Data.addCartList(widget.product, count_value);

                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(msg: 'error');
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "ADD TO CART",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MaterialButton(
                    color: Colors.deepOrange,
                    elevation: 0,
                    onPressed: () {
                      if (count_value > 0) {
                        cart buyitem = cart(count_value, widget.product);
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => Deliveryfragment([buyitem])));
                      } else {
                        Fluttertoast.showToast(msg: 'error');
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "ORDER NOW",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
