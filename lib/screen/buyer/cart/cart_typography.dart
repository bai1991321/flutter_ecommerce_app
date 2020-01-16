import 'package:flutter/material.dart';

class CartSubtitle extends StatelessWidget {
  const CartSubtitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Colors.grey));
  }
}

class CartTitle extends StatelessWidget {
  const CartTitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
    );
  }
}
