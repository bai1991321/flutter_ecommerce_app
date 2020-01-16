import 'dart:math';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask_product.dart';
import 'package:flutter_ecommerce/utils/form_validate.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:intl/intl.dart';

import 'ask_input_fragment.dart';

class AskProductWidget extends StatefulWidget {
  AskProduct askProduct;
  String askId;

  AskProductWidget({this.askProduct, this.askId});

  _AskProductWidgetState createState() => _AskProductWidgetState();
}

class _AskProductWidgetState extends State<AskProductWidget>
    with TickerProviderStateMixin {
  final _formAddProductKey = GlobalKey<FormState>();
  String _product_name;
  String _quentity;
  String _specifiction;
  String _description;
  String _delivery_date;
  String _buget;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              final form = _formAddProductKey.currentState;
              if (form.validate()) {
                form.save();
                if (widget.askProduct != null &&
                    widget.askProduct.id.isNotEmpty) {
                  AskInputFragment.product_list.remove(widget.askProduct);
                  AskInputFragment.product_list.add(new AskProduct(
                      widget.askProduct.id,
                      Util.uid,
                      widget.askId,
                      _product_name,
                      _quentity,
                      _specifiction,
                      _description,
                      _delivery_date,
                      _buget));
                } else {
                  AskInputFragment.product_list.add(new AskProduct(
                      "${new Random().nextInt(10000)}${new Random().nextInt(10000)}${new Random().nextInt(10000)}${new Random().nextInt(10000)}",
                      Util.uid,
                      widget.askId,
                      _product_name,
                      _quentity,
                      _specifiction,
                      _description,
                      _delivery_date,
                      _buget));
                }
                Navigator.pop(context);
              }
            },
            child: Text(
              widget.askProduct != null && widget.askProduct.id.isNotEmpty
                  ? "UPDATE"
                  : 'SAVE',
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: Form(
            key: _formAddProductKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Product name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.shopping_basket),
                  ),
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  initialValue: widget.askProduct != null &&
                          widget.askProduct.product_name.isNotEmpty
                      ? widget.askProduct.product_name
                      : "",
                  validator: FormValidate().validateMustInput,
                  onSaved: (value) => _product_name = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.straighten),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  initialValue: widget.askProduct != null &&
                          widget.askProduct.quantity.isNotEmpty
                      ? widget.askProduct.quantity
                      : "",
                  validator: FormValidate().validatePrice,
                  onSaved: (value) => _quentity = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Specifications',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.folder_special),
                  ),
                  maxLength: 2000,
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  initialValue: widget.askProduct != null &&
                          widget.askProduct.specifications.isNotEmpty
                      ? widget.askProduct.specifications
                      : "",
                  validator: FormValidate().validateMustInput,
                  onSaved: (value) => _specifiction = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLength: 2000,
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  initialValue: widget.askProduct != null &&
                          widget.askProduct.description.isNotEmpty
                      ? widget.askProduct.description
                      : "",
                  validator: FormValidate().validateMustInput,
                  onSaved: (value) => _description = value,
                ),
                DateTimePickerFormField(
                  decoration: InputDecoration(
                    labelText: 'Delivery date',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  dateOnly: true,
                  maxLength: 15,
                  format: DateFormat("yyyy-MM-dd"),
                  keyboardType: TextInputType.datetime,
                  initialDate: widget.askProduct != null &&
                          widget.askProduct.delivery_date.isNotEmpty
                      ? widget.askProduct.delivery_date
                      : DateTime.now(),
                  onSaved: (value) => _delivery_date = value.toString(),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Budget',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.numberWithOptions(signed: false),
                  initialValue: widget.askProduct != null &&
                          widget.askProduct.budget.isNotEmpty
                      ? '\$' + widget.askProduct.budget
                      : "",
                  validator: FormValidate().validatePrice,
                  onSaved: (value) => _buget = value.replaceAll("\$", ""),
                ),
              ],
            )),
      ),
    );
  }
}
