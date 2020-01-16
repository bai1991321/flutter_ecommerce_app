import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask_product.dart';
import 'package:flutter_ecommerce/model/bid.dart';
import 'package:flutter_ecommerce/services/firestore_ask_products_service.dart';
import 'package:flutter_ecommerce/services/firestore_bids_service.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:flutter_ecommerce/widgets/circle_company_logo.dart';
import 'package:intl/intl.dart';

class BidCanceledFragment extends StatefulWidget {
  @override
  _BidCanceledFragmentState createState() => _BidCanceledFragmentState();
}

class _BidCanceledFragmentState extends State<BidCanceledFragment>
    with SingleTickerProviderStateMixin {
  List<Bid> bidsList = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData().then((d) {
      setState(() {
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: !loading
          ? RefreshIndicator(
              onRefresh: () async {
                bidsList.clear();
                await getData();
                setState(() {});
              },
              child: JobListView(list: bidsList),
            )
          : Center(
              child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
            ),
    );
  }

  Future<List<String>> getData() async {
    //initialize a new list
    List<String> myList = [];

    //connect to flutter jobs web site
    FirebaseFirestoreServiceBids db = FirebaseFirestoreServiceBids();

    //parse and extract the data from the web site

    db.getBidListByuID(Util.uid, 'canceled').listen((snapshot) {
      final List<Bid> products = snapshot.documents
          .map((doc_snap) => Bid.fromMap(doc_snap.data))
          .toList();
      setState(() {
        this.bidsList = products;
        print(this.bidsList.length);
        loading = false;
      });
    });
    // remove the first item which is the title item in the table

    print("data loaded");
    //just to wait until the get request completed
    return myList;
  }
}

class JobListView extends StatefulWidget {
  const JobListView({
    Key key,
    this.list,
  }) : super(key: key);
  final List<Bid> list;

  @override
  JobListViewState createState() {
    return new JobListViewState();
  }
}

class JobListViewState extends State<JobListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.list.isNotEmpty
            ? widget.list.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Stack(
                    children: <Widget>[
                      // Dismissible(
                      //   key: Key(item.productID),
                      //   direction: DismissDirection.startToEnd,
                      // onDismissed: (direction) {
                      //   setState(() {
                      //     widget.list.removeAt(widget.list.indexOf(item));
                      //   });
                      // },
                      // child:
                      ClippedItem(item: item),
                      // ),
                      CircleCompanyLogo(
                        image_url: item.imageURL,
                      ),
                    ],
                  ),
                );
              }).toList()
            : [Container()]);
  }
}

class ClippedItem extends StatefulWidget {
  const ClippedItem({
    Key key,
    this.item,
  }) : super(key: key);

  final Bid item;

  @override
  ClippedItemState createState() {
    return ClippedItemState();
  }
}

class ClippedItemState extends State<ClippedItem>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  AskProduct product;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween<Offset>(begin: Offset(200.0, 0.0), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);
    FirebaseFirestoreServiceAskProducts db =
        FirebaseFirestoreServiceAskProducts();
    db
        .getAskProductByID(widget.item.askProductID)
        .listen((data) => data.documents.forEach((f) {
              setState(() {
                product = AskProduct.fromMap(f.data);
              });
            }));

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: ClipPath(
        clipper: Clipper(),
        child: Card(
          color: Colors.white,
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          child: InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Detail(product),
              //   ),
              // );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, top: 20.0, right: 10.0, bottom: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                            height: 50.0,
                            child: Text(
                              product == null
                                  ? "loading..."
                                  : product.product_name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        color: Colors.grey,
                      ),
                      Text(
                        product.budget + "(${widget.item.amount}:Bid Price)",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        DateFormat.yMMMd().format(DateTime.parse(
                                 widget.item.created_date.split(" ")[0]
                                .replaceAll(' ', 'T')
                                .replaceAll(':', '')
                                .replaceAll('-', ''))),
                        style: TextStyle(color: Colors.grey),
                      ),
                      Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    var radius = 28.0;

    path.lineTo(0.0, size.height / 2 + radius);
    path.arcToPoint(
      Offset(0.0, size.height / 2 - radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
