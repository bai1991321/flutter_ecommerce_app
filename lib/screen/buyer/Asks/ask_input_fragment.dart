import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask_product.dart';
import 'package:flutter_ecommerce/services/firestore_ask_products_service.dart';
import 'package:flutter_ecommerce/services/firestore_asks_service.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ask_product_widget.dart';

class AskInputFragment extends StatefulWidget {
  static List<AskProduct> product_list = [];
  String ask_title;

  AskInputFragment({this.ask_title});

  @override
  _AskInputFragmentState createState() {
    return new _AskInputFragmentState();
  }
}

class _AskInputFragmentState extends State<AskInputFragment>
    with TickerProviderStateMixin {
  TabController _controller;
  String askID;

  // String _ask_description;
  FirebaseFirestoreServiceAskProducts pdb =
      FirebaseFirestoreServiceAskProducts();
  FirebaseFirestoreServiceAsks db = FirebaseFirestoreServiceAsks();

  @override
  void initState() {
    super.initState();
    askID =
        "${new Random().nextInt(10000)}${new Random().nextInt(10000)}${new Random().nextInt(10000)}${new Random().nextInt(10000)}";
    AskInputFragment.product_list = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _productListView(AskProduct pro) {
    return new Card(
      shape: new BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: new ListTile(
          title: new Text(pro.product_name),
          trailing: new Text('\$' + pro.budget)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return AskInputFragment.product_list != null
        ? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "${AskInputFragment.product_list.length.toString()} Products",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                _buildProductList(context, AskInputFragment.product_list),
              ],
            ),
          )
        : Center(
            child: Text(
              "There is no product in the pitch.",
              style: Theme.of(context).textTheme.title,
            ),
          );
  }

  Widget _buildProductList(BuildContext context, List<AskProduct> plist) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      children: plist.map((data) => _buildProductItem(context, data)).toList(),
    );
  }

  Widget _buildProductItem(BuildContext context, AskProduct data) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Slidable.builder(
        delegate: SlidableStrechDelegate(),
        secondaryActionDelegate: new SlideActionBuilderDelegate(
            actionCount: 2,
            builder: (context, index, animation, renderingMode) {
              if (index == 0) {
                return new IconSlideAction(
                  caption: 'Edit',
                  color: Colors.blue,
                  icon: Icons.edit,
                  onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AskProductWidget(
                                askProduct: data,
                              ),
                          fullscreenDialog: true,
                        ),
                      ),
                  closeOnTap: false,
                );
              } else {
                return new IconSlideAction(
                  caption: 'Delete',
                  closeOnTap: false,
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => _buildConfirmationDialog(context, data),
                );
              }
            }),
        key: Key(data.id),
        child: ListTile(
          title: Text(data.product_name),
          onTap: () => {},
        ),
      ),
    );
  }

  Future<bool> _buildConfirmationDialog(
      BuildContext context, AskProduct documentID) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Product will be deleted'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
                child: Text('Delete'),
                onPressed: () {
                  AskInputFragment.product_list.remove(documentID);
                  Navigator.of(context).pop(true);
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.ask_title ?? ''),
          centerTitle: true,
          backgroundColor: Colors.amber,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                if (AskInputFragment.product_list == null ||
                    AskInputFragment.product_list.length < 1) {
                  Fluttertoast.showToast(
                      msg: 'Product list must be required at least 1.',
                      toastLength: Toast.LENGTH_SHORT);
                  return;
                }
                _showConfirmDialog();
              },
              child: Text(
                'SAVE',
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Form(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 54.0),
                  child: Material(
                    elevation: 8.0,
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(32.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AskProductWidget(),
                              fullscreenDialog: true,
                            ),
                          ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.add, color: Colors.white),
                            Padding(padding: EdgeInsets.only(right: 16.0)),
                            Text('ADD ITEMS',
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                  )),
              SafeArea(child: _buildBody(context)),
            ],
          ),
        ));
  }

  void _navigateToAddProduct() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AskProductWidget(),
        fullscreenDialog: true,
      ),
    );
  }

  void _showConfirmDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Save"),
          content: new Text("Do you have finished?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                // Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                db
                    .createAsk(askID, Util.uid, widget.ask_title, '')
                    .then((result) {
                  Fluttertoast.showToast(
                    msg:
                        "Your requirements for the Product '${widget.ask_title}' has been posted.",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                  for (var f in AskInputFragment.product_list) {
                    pdb
                        .createAskProduct(
                            f.id,
                            askID,
                            f.product_name,
                            f.quantity,
                            f.specifications,
                            f.description,
                            f.delivery_date,
                            f.budget)
                        .then((result) {
                      // Fluttertoast.showToast(msg: "Your All Products are posted.",toastLength: Toast.LENGTH_SHORT,);
                    });
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
