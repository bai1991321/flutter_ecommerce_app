import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask.dart';
import 'package:flutter_ecommerce/model/ask_product.dart';
import 'package:flutter_ecommerce/screen/buyer/bids/bid_active_page.dart';
import 'package:flutter_ecommerce/screen/buyer/invite/company_list_page.dart';
import 'package:flutter_ecommerce/services/firestore_ask_products_service.dart';
import 'package:flutter_ecommerce/services/firestore_asks_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'ask_edit_fragment.dart';

class AskDetailPage extends StatefulWidget {
  Ask _ask;

  AskDetailPage(this._ask);

  _AskDetailPageState createState() => _AskDetailPageState();
}

class _AskDetailPageState extends State<AskDetailPage>
    with TickerProviderStateMixin {
  FirebaseFirestoreServiceAskProducts pdb =
      FirebaseFirestoreServiceAskProducts();
  List<AskProduct> product_list;

  void initState() {
    super.initState();
    var lists = new List<AskProduct>();
    pdb.getAskProcutsListByaID(widget._ask.id).listen((data) {
      lists.clear();
      data.documents.forEach((f) {
        lists.add(AskProduct.fromMap(f.data));
        setState(() {
          this.product_list = lists;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getRichText(title, name) {
      return RichText(
        text: TextSpan(
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                  text: title, style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: name, style: TextStyle(color: Colors.grey)),
            ]),
      );
    }

    final _askDetailCard = Card(
      elevation: 5.0,
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: 150.0,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget._ask.ask_title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat.yMMMd().format(DateTime.parse(widget
                      ._ask.created_date
                      .replaceAll(' ', 'T')
                      .replaceAll(':', '')
                      .replaceAll('-', ''))),
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  color: Colors.grey,
                ),
                Text(widget._ask.description),
              ],
            ),
          )),
    );

    final _productListCard = Card(
      elevation: 5.0,
      color: Colors.grey[100],
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Container(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.90,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount:
                      this.product_list == null ? 0 : this.product_list.length,
                  itemBuilder: (context, index) {
                    return _buildProductItem(
                        context, product_list.toList()[index]);
                  }),
            )),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: Text("Bids submitted"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.edit,
            ),
            onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AskEditFragment(widget._ask),
                    fullscreenDialog: true,
                  ),
                ),
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.delete,
            ),
            onPressed: () {
              Alert(
                context: context,
                type: AlertType.warning,
                title: widget._ask.ask_title,
                desc: "Cancel this ask?",
                buttons: [
                  DialogButton(
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      FirebaseFirestoreServiceAsks ask =
                          FirebaseFirestoreServiceAsks();
                      widget._ask.setStatus("canceled");
                      ask.updateAsk(widget._ask);
                    },
                    color: Color.fromRGBO(0, 179, 134, 1.0),
                  ),
                  DialogButton(
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(116, 116, 191, 1.0),
                      Color.fromRGBO(52, 138, 199, 1.0)
                    ]),
                  )
                ],
              ).show();
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.33,
              color: Colors.amber,
            ),
            Positioned(
              top: 15,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  children: <Widget>[
                    _askDetailCard,
                    SizedBox(
                      height: 20.0,
                    ),
                    _productListCard,
                    Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        margin: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 54.0),
                        child: Material(
                          elevation: 8.0,
                          color: Colors.amber[800],
                          borderRadius: BorderRadius.circular(32.0),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        BidActivePage(widget._ask))),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // Icon(Icons.add, color: Colors.white),
                                  // Padding(padding: EdgeInsets.only(right: 16.0)),
                                  Text('Review Bids',
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              color: Colors.deepOrange,
              elevation: 0,
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => CompanyListPage())),
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Invite",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(BuildContext ctn, AskProduct data) {
    final navigator = Navigator.of(ctn);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Slidable.builder(
        delegate: SlidableStrechDelegate(),
        key: Key(data.id),
        child: ListTile(
          title: Text(data.product_name),
          onTap: () => Alert(
                context: ctn,
                type: AlertType.none,
                title: data.product_name,
                desc: '\$${data.budget}',
                content: Container(
                  height: 200,
                  width: double.maxFinite,
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: <Widget>[
                      ListTile(
                        title: Text('Quantity:'),
                        trailing: Text(data.quantity),
                      ),
                      ListTile(
                        title: Text('Delivery Date:'),
                        trailing: Text(DateFormat.yMMMd().format(DateTime.parse(
                            data.delivery_date
                                .replaceAll(' ', 'T')
                                .replaceAll(':', '')
                                .replaceAll('-', '')))),
                      ),
                      ListTile(
                        title: Text('Specification'),
                        subtitle: Text(
                          data.specifications,
                        ),
                      ),
                      ListTile(
                        title: Text('Description'),
                        subtitle: Text(
                          data.description,
                        ),
                      ),
                    ],
                  ),
                ),
                buttons: [
                  DialogButton(
                    child: Text(
                      "close",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => navigator.pop(),
                    gradient: LinearGradient(
                        colors: [Colors.amber[700], Colors.amber]),
                  ),
                ],
              ).show(),
        ),
      ),
    );
  }
}
