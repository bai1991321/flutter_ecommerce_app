import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/bid.dart';
import 'package:flutter_ecommerce/model/product.dart';
import 'package:flutter_ecommerce/screen/buyer/update_bid_page.dart';
import 'package:flutter_ecommerce/services/firestore_bids_service.dart';
import 'package:flutter_ecommerce/services/firestore_product_service.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:flutter_ecommerce/widgets/circle_company_logo.dart';

class BidCreatedFragment extends StatefulWidget {
  @override
  _BidCreatedFragmentState createState() => _BidCreatedFragmentState();
}

class _BidCreatedFragmentState extends State<BidCreatedFragment>
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

    db.getBidListByuID(Util.uid, 'created').listen((snapshot) {
      final List<Bid> bids = snapshot.documents
          .map((doc_snap) => Bid.fromMap(doc_snap.data))
          .toList();
      setState(() {
        this.bidsList = bids;
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
            : []);
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
  Product product;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween<Offset>(begin: Offset(200.0, 0.0), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);
    FirebaseFirestoreServiceProduct db = FirebaseFirestoreServiceProduct();
    db
        .getProductByID(widget.item.buyerID)
        .listen((data) => data.documents.forEach((f) {
              setState(() {
                product = Product.fromMap(f.data);
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpgradeBidPage(product, widget.item),
                ),
              );
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
                              product == null ? "loading..." : product.itemname,
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
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                      Text(
                        widget.item.created_date.trim(),
                        style: TextStyle(color: Colors.grey),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        "no location",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.location_city,
                        color: Colors.black,
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
