import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_ecommerce/screen/buyer/checkout/delivery_screen.dart';
import 'package:flutter_ecommerce/utils/data.dart';

import 'cart_list_item.dart';

class CartPage extends StatefulWidget {
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  String _subtotalPrice = '0.00';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subtotalPrice = getSubTotalPrice().toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text("Your Cart"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: Data.cart_list.length,
                    itemBuilder: (ctx, index) {
                      return CartListItem(
                        cart_index: index,
                      );
                    })),
            SizedBox(
              height: 10.0,
            ),
            _buildTotals()
          ],
        ));
  }

  Widget _buildTotals() {
    return ClipOval(
      clipper: OvalTopBorderClipper(),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 5.0,
                color: Colors.grey.shade700,
                spreadRadius: 80.0),
          ],
          color: Colors.white,
        ),
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Subtotal",
                ),
                Text('\$' + _subtotalPrice),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("fee"),
                Text("\$. " + (double.parse(_subtotalPrice) * 0.1).toString()),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total"),
                Text("\$. " + (double.parse(_subtotalPrice) * 1.1).toString()),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => Deliveryfragment(Data.cart_list)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Continue to Checkout",
                      style: TextStyle(color: Colors.white)),
                  // Text("Rs. 1600", style: TextStyle(color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double getSubTotalPrice() {
    double total = 0;
    for (var item in Data.cart_list) {
      total += item.count * double.parse(item.product.price);
    }
    return total;
  }
}
