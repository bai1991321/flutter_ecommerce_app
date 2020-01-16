import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/product.dart';
import 'package:flutter_ecommerce/model/Category.dart';
import 'package:flutter_ecommerce/services/firestore_product_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/model/Category.dart';

import './../product_page.dart';

class ProductsListPage extends StatefulWidget {
  Category category;

  ProductsListPage({this.category});

  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  FirebaseFirestoreServiceProduct db = FirebaseFirestoreServiceProduct();
  List<Product> products = [];
  bool isLoading = true;
  bool isExtended = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initProducts(widget.category);
  }

  initProducts(Category category) {

    // db.getProductListBySubcategory(category.id).listen((test) {
    //   test.documents.forEach((f) {
    //     Product item = Product.fromMap(f.data);
    //     setState(() {
    //       products.add(item);
    //     });
    //   });
    //   setState(() {
    //     if (category != null && category != 'Other') products.clear();
    //     isLoading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              !isExtended
                  ? RaisedButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 32.0),
                      // onPressed: () => launch("https://pighetti.design"),
                      color: Colors.amber[900],
                      child: Text(
                        "Recommended products",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99.9),
                      ),
                      onPressed: () {
                        setState(() {
                          isExtended = true;
                        });
                      },
                    )
                  : Container(),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: widget.category ==null? db.getProductList() : db.getProductListBySubcategory(widget.category.id),
                  builder: (context, snap) {
                    switch (snap.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator(),);
                        break;
                      default:
                        return SafeArea(
                        child: GridView.builder(
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      orientation == Orientation.portrait ? 2 : 4,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 0.7,
                                ),
                                itemCount: snap.data.documents.length < 5
                                    ? snap.data.documents.length
                                    : isExtended ? snap.data.documents.length : 4,
                                itemBuilder: (context, index){
                                  return _buildGridCard(context, Product.fromMap(snap.data.documents[index].data));
                                },
                              ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  Card _buildGridCard(BuildContext context, Product item) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Card(
      color: Colors.transparent,
      elevation: 8.0,
      child: new InkResponse(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new ProductPage(item);
          }));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Stack(
            children: <Widget>[
              Hero(
                tag: item.id,
                child: item.imageUrl != null
                    ? Container(
                        color: Colors.blueGrey.shade300,
                        child: new CachedNetworkImage(
                          imageUrl: item.imageUrl[0],
                          height: double.infinity,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : new FlutterLogo(),
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                  width: orientation == Orientation.portrait
                      ? (MediaQuery.of(context).size.width - 26.0) / 2
                      : (MediaQuery.of(context).size.width - 26.0) / 4,
                  color: Colors.white.withOpacity(0.88),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                      Padding(
                        padding: const EdgeInsets.only(left: 7.0, right: 7.0),
                        child: Text(
                          item.itemname,
                          style: new TextStyle(
                              fontSize: 15.5,
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Padding(
                          padding: EdgeInsets.only(left: 7.0, right: 7.0),
                          child: Text(
                            '\$' + item.price,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black.withOpacity(0.75),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 4.0))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
