import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/firebase_shippo_service.dart';
import 'package:flutter_ecommerce/utils/data.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_ecommerce/model/product.dart';

import './../../../flutter-shippo/models/addresses/address.dart';
import './../../../flutter-shippo/models/parcels/parcel.dart';
import './../../../flutter-shippo/models/shipment/shipment.dart';
import './../../../flutter-shippo/services/parcels/create.dart';
import './../../../flutter-shippo/services/shipment/create.dart';
import 'select_rate.dart';

class PaymentScreen extends StatefulWidget {
  List<cart> itemList = [];
  Address _address;

  PaymentScreen(this.itemList, this._address);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  IconData _backIcon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  int radioValue = 0;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }

  bool _saving = false;
  String toolbarname = 'CheckOut';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final double height = MediaQuery.of(context).size.height;

    AppBar appBar = AppBar(
      leading: IconButton(
        icon: Icon(_backIcon()),
        alignment: Alignment.centerLeft,
        tooltip: 'Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(toolbarname),
      backgroundColor: Colors.white,
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
    );

    return new Scaffold(
        key: _scaffoldKey,
        appBar: appBar,
        body: ModalProgressHUD(
          child: new Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5.0),
                  child: Card(
                      child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // three line description
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Delivery',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black38),
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.play_circle_outline,
                                                  color: Colors.black38,
                                                ),
                                                onPressed: null)
                                          ],
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Payment',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.check_circle,
                                                  color: Colors.blue,
                                                ),
                                                onPressed: null)
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          )))),
              _verticalDivider(),
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Card(
                    child: Container(
                      color: Colors.green.shade100,
                      child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                          child: Text(
                              "GET EXTRA 10% OFF* with MONEY bank Simply Save Credit card. T&C.",
                              maxLines: 10,
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black87))),
                    ),
                  )),
              new Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                    left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                child: new Text(
                  'Payment Method',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              _verticalDivider(),
              new Container(
                  height: 264.0,
                  margin: EdgeInsets.all(10.0),
                  child: Card(
                    child: Container(
                      child: Container(
                          child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Wallet / UPI",
                                    maxLines: 10,
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black)),
                                Radio<int>(
                                    value: 0, groupValue: 0, onChanged: null),
                              ],
                            ),
                          ),
                          Divider(),
                          _verticalD(),
                          Container(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Net Banking",
                                      maxLines: 10,
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black)),
                                  Radio<int>(
                                      value: 0,
                                      groupValue: radioValue,
                                      onChanged: null),
                                ],
                              )),
                          Divider(),
                          _verticalD(),
                          Container(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Credit / Debit / ATM Card",
                                      maxLines: 10,
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black)),
                                  Radio<int>(
                                      value: 0,
                                      groupValue: 0,
                                      onChanged: handleRadioValueChanged),
                                ],
                              )),
                          Divider(),
                          _verticalD(),
                          Container(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Cash on Delivery",
                                      maxLines: 10,
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black)),
                                  Radio<int>(
                                      value: 0, groupValue: 0, onChanged: null),
                                ],
                              )),
                          Divider(),
                        ],
                      )),
                    ),
                  )),
              Container(
                  alignment: Alignment.bottomLeft,
                  height: 50.0,
                  child: Card(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.info), onPressed: null),
                        Text(
                          'Total :',
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$ ${_getTotalPrice()}',
                          style:
                              TextStyle(fontSize: 17.0, color: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: OutlineButton(
                                borderSide: BorderSide(color: Colors.green),
                                child: const Text('PROCEED TO PAY'),
                                textColor: Colors.green,
                                onPressed: () {
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Details()));
                                  _createPayment();
                                },
                                shape: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          inAsyncCall: _saving,
        ));
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 5.0),
      );

  _createPayment() async {
    setState(() {
      _saving = true;
    });
    List<ShipmentCarrier> shipmentList = [];
    FirebaseShippoService shippodb = new FirebaseShippoService();
    for (cart item in widget.itemList) {
      List<Parcel> parcelList = [];
      int n = 0;
      while (n < item.count) {
        n++;
        ParcelBody requestBody = new ParcelBody(
            length: item.product.length,
            width: item.product.width,
            height: item.product.height,
            distance_unit: item.product.distance_unit,
            weight: item.product.weight,
            mass_unit: item.product.mass_unit);
        Parcel response = await parcelCreate(requestBody);

        parcelList.add(response);
        await shippodb.createShippo(
            Util.uid, "parcels", response.object_id, response.toMap());
      }

      Address addressfrom = await shippodb
          .getShippo(item.product.supplier, "addresses")
          .map((convert) => Address.fromMap(convert.documents.first.data))
          .first;

      ShipmentBody shipItem = ShipmentBody(
          address_to: widget._address,
          address_from: addressfrom,
          address_return: addressfrom,
          parcels: parcelList,
          metadata: "${item.product.itemname}",
          asyn: false);
      Shipment ship = await shipmentCreate(shipItem);

      shipmentList.add(ShipmentCarrier(ship, [item]));
    }
    setState(() {
      _saving = false;
    });
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SelectRateFragment(shipmentList, _getTotalPrice())));
  }

  _getTotalPrice() {
    double totalPrice = 0.0;
    for (cart item in widget.itemList) {
      totalPrice += double.parse(item.product.price) * (item.count);
    }
    return (totalPrice * 1.1).toStringAsFixed(2);
  }
}

class ShipmentCarrier {
  Shipment shipment;
  List<cart> products;

  ShipmentCarrier(this.shipment, this.products);
}
