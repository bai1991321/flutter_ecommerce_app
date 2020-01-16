import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/firestore_product_service.dart';
import 'package:flutter_ecommerce/services/firebase_shippo_service.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stripe_payment/stripe_payment.dart';

import './../../../flutter-shippo/models/rates/rate.dart';
import './../../../flutter-shippo/models/transactions/transaction.dart';
import './../../../flutter-shippo/services/transactions/create.dart';
import 'Payment_Screen.dart';
import 'sucess_screen.dart';

class SelectRateFragment extends StatefulWidget {
  List<ShipmentCarrier> _shipList;
  String _amount;

  SelectRateFragment(this._shipList, this._amount);

  _SelectRateFragmentState createState() =>
      _SelectRateFragmentState(_shipList.length);
}

class _SelectRateFragmentState extends State<SelectRateFragment>
    with TickerProviderStateMixin {
  _SelectRateFragmentState(int n) {
    ratesList = List<Rate>(n);
  }

  List<Rate> ratesList = [];
  bool _saving = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Rate"),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: widget._shipList.length,
          itemBuilder: (ctx, index) {
            int selected_index = -1;
            ratesList[index] = null;
            return StatefulBuilder(
              builder: (con, StateSetter setState) {
                return Card(
                  child: ExpansionTile(
                    leading: Text(
                        "${widget._shipList[index].shipment.rates.length}"),
                    title: Text(widget._shipList[index].shipment.metadata),
                    children: widget._shipList[index].shipment.rates.map((f) {
                      return StatefulBuilder(
                        builder: (context, StateSetter _setState) {
                          return Card(
                            color: f == ratesList[index]
                                ? Colors.blue[100]
                                : Colors.white,
                            child: ListTile(
                              leading: Image.network(f.provider_image_75),
                              title: Text(f.provider),
                              subtitle: Text("${f.amount} ${f.currency}"),
                              trailing: Text("${f.estimated_days} days"),
                              onTap: () {
                                setState(() {
                                  _setState(() {
                                    this.ratesList[index] = f;
                                  });
                                });
                              },
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            );
          },
        ),
        inAsyncCall: _saving,
      ),
      bottomNavigationBar: new Container(
        height: 65,
        child: MaterialButton(
          color: Colors.deepOrange,
          onPressed: doCheckAndStart,
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Confirm",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
          // ),
        ),
      ),
    );
  }

  doCheckAndStart() async {
    FirebaseShippoService shippodb = FirebaseShippoService();
    FirebaseFirestoreServiceProduct proDB =FirebaseFirestoreServiceProduct();
    setState(() {
      _saving = true;
    });
    final List<Rate> _list = this.ratesList.toList();
    StripeSource.setPublishableKey("pk_test_9YfVq1LVjyXD35RYepsJj1y8");
    String token = await StripeSource.addSource();
    for (Rate item in _list) {
      if (item == null) {
        Fluttertoast.showToast(msg: "please select rates all");
        setState(() {
          _saving = false;
        });
        return;
      }
    }
    for (Rate item in _list) {
      int index = _list.indexOf(item);
      TransationRateBody _body = TransationRateBody(
          rate: item.object_id,
          label_file_type: "PDF",
          asyn: false,
          metadata: widget._shipList[index].shipment.metadata);
      await shippodb.createShippo(
        Util.uid,
        "shipments",
        widget._shipList[index].shipment.object_id,
        widget._shipList[index].shipment.toMap(),
      );
      Transactions _trans = await transactionRateCreate(_body);
      await shippodb.createShippo(
          Util.uid, "transactions", _trans.object_id, _trans.toMap());
      await shippodb.createShippo(widget._shipList[index].products[0].product.supplier,
          "transactions", _trans.object_id, _trans.toMap());
      String content =
          '${Util.companyname} has bought your product.Please Check shipment Label. ${_trans.label_url}';
      onSendMessage(
          content, Util.uid, widget._shipList[index].products[0].product.supplier);

      //Show card added successfully...
      Firestore.instance
          .collection('stripe')
          .document(Util.uid)
          .collection('tokens')
          .document()
          .setData({'tokenId': token});
      Firestore.instance
          .collection('stripe')
          .document(Util.uid)
          .collection('charges')
          .document()
          .setData({
        'product': widget._shipList[index].shipment.metadata,
        'token': token,
        'amount': widget._amount,
        'shipment': item.object_id,
        'transaction': _trans.object_id,
        'provider': item.provider,
        'tracking': _trans.tracking_number,
        'shipfee': item.amount
      });
      Firestore.instance
          .collection('stripe')
          .document(widget._shipList[index].products[0].product.supplier)
          .collection('charges')
          .document()
          .setData({
        'product': widget._shipList[index].shipment.metadata,
        'token': "token",
        'amount': widget._amount,
        'shipment': item.object_id,
        'transaction': _trans.object_id,
        'provider': item.provider,
        'tracking': _trans.tracking_number,
        'shipfee': item.amount
      });
      Fluttertoast.showToast(msg: "Sucessful!" );
      widget._shipList[index].products.forEach((f) {
        f.product.amount = (int.parse(f.product.amount) - f.count).toString();
        proDB.updateProduct(f.product);
      });
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SucessScreen()));
    setState(() {
      _saving = false;
    });
  }

  void onSendMessage(String content, String me, String other) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      String groupChatId = readLocal(me, other);
      var documentReference = Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());
      Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .setData({'buyer': me, 'supplier': other});
      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': me,
            'idTo': other,
            'timestamp': FieldValue.serverTimestamp(),
            'content': content,
            'type': 0
          },
        );
      });
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  String readLocal(String me, String other) {
    // prefs = await SharedPreferences.getInstance();
    // id = prefs.getString('id') ?? '';
    if (Util.type == 'buyer') {
      return '$me-$other';
    } else {
      return '$other-$me';
    }
  }
}
