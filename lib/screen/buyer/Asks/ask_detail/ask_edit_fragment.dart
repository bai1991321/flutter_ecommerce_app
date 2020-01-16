import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask.dart';
import 'package:flutter_ecommerce/model/ask_product.dart';
import 'package:flutter_ecommerce/services/firestore_ask_products_service.dart';
import 'package:flutter_ecommerce/services/firestore_asks_service.dart';
import 'package:flutter_ecommerce/utils/form_validate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ask_product_edit_widget.dart';

class AskEditFragment extends StatefulWidget {
  Ask _ask;

  AskEditFragment(this._ask);

  @override
  _AskEditFragmentState createState() {
    return new _AskEditFragmentState();
  }
}

class _AskEditFragmentState extends State<AskEditFragment>
    with TickerProviderStateMixin {
  List<AskProduct> product_list = [];
  TabController _controller;

  String _ask_title;
  String _ask_description;
  FirebaseFirestoreServiceAskProducts pdb =
      FirebaseFirestoreServiceAskProducts();
  FirebaseFirestoreServiceAsks db = FirebaseFirestoreServiceAsks();
  final _formAddAskKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pdb.getAskProcutsListByaID(widget._ask.id).listen((snapshot) {
      setState(() {
        product_list =
            snapshot.documents.map((f) => AskProduct.fromMap(f.data)).toList();
      });
    });
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
    return product_list != null
        ? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "${product_list.length.toString()} Products",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                _buildProductList(context, product_list),
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
                          builder: (context) => AskProductEdit(
                                askProduct: data,
                                askId: data.askId,
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
                  setState(() {
                    pdb.deleteAsk(documentID.id);
                    product_list.remove(documentID);
                  });
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
          title: Text("Edit Ask"),
          centerTitle: true,
          backgroundColor: Colors.amber,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                if (_formAddAskKey.currentState.validate()) {
                  _formAddAskKey.currentState.save();
                  if (product_list == null || product_list.length <= 0) {
                    Fluttertoast.showToast(
                        msg: 'Product list must be required at least 1.',
                        toastLength: Toast.LENGTH_SHORT);
                    return;
                  }
                  widget._ask.setTitle(_ask_title);
                  widget._ask.setDescription(_ask_description);
                  db.updateAsk(widget._ask).then((result) {
                    Fluttertoast.showToast(
                      msg:
                          "Your requirements for the Product '${_ask_title}' has been posted.",
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  });
                  Navigator.of(context).pop();
                }
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
          key: _formAddAskKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: TextFormField(
                  maxLength: 20,
                  initialValue: widget._ask.ask_title,
                  decoration: InputDecoration(
                    hintText: 'please type your ask title.',
                    icon: Icon(Icons.title, color: Colors.red),
                    labelText: "Ask title",
                  ),
                  validator: FormValidate().validateMustInput,
                  onSaved: (value) => _ask_title = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: TextFormField(
                  maxLength: 2000,
                  maxLines: 3,
                  initialValue: widget._ask.description,
                  decoration: InputDecoration(
                    hintText: 'please type your ask description.',
                    icon: Icon(Icons.description, color: Colors.red),
                    labelText: "Ask description",
                  ),
                  validator: FormValidate().validateMustInput,
                  onSaved: (value) => _ask_description = value,
                ),
              ),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                      child: new Divider(
                    color: Colors.grey,
                  )),
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text('Products'),
                  ),
                  new Expanded(
                      child: new Divider(
                    color: Colors.grey,
                  )),
                ],
              ),
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
                              builder: (context) =>
                                  AskProductEdit(askId: this.widget._ask.id),
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
        builder: (context) => AskProductEdit(),
        fullscreenDialog: true,
      ),
    );
  }
}
