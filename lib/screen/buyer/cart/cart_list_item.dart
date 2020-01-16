import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utils/data.dart';

import 'cart_typography.dart';

class CartListItem extends StatefulWidget {
  final int cart_index;

  const CartListItem({this.cart_index});

  _CartListItemState createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  GlobalKey stepperCartKey = GlobalKey();
  int count_value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count_value = Data.cart_list[widget.cart_index].count;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
            height: 80.0,
            child: CachedNetworkImage(
                imageUrl: Data.cart_list[widget.cart_index].product.imageUrl[0])),
        title: Container(
          height: 120.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new CartTitle(
                  text: Data.cart_list[widget.cart_index].product.itemname),
              new CartSubtitle(
                  text: 'price: \$' +
                      Data.cart_list[widget.cart_index].product.price),
            ],
          ),
        ),
        trailing: Column(
          children: <Widget>[
            // StepperTouch(
            //                           key: stepperCartKey,
            //                           initialValue: Data.cart_list[widget.cart_index].count,
            //                           direction: Axis.vertical,
            //                           withSpring: false,
            //                           onChanged: (int value) {
            //                             setState(() {
            //                                   count_value = value;
            //                                   Data.cart_list[widget.cart_index].setCount(value);
            //                                 });
            //                           },
            //                         ),
          ],
        ),
      ),
    );
  }
}
