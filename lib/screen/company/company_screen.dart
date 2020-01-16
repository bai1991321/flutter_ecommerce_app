import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/screen/company/company_screen_body.dart';
import 'package:flutter_ecommerce/screen/company/footer/friend_detail_footer.dart';
import 'package:flutter_ecommerce/screen/company/header/company_detail_header.dart';

class CompanyScreen extends StatefulWidget {
  CompanyScreen(
    this._company,
  );

  final Company _company;

  @override
  _CompanyScreenState createState() => new _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          Colors.orange,
          Colors.amber,
        ],
      ),
    );

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new FriendDetailHeader(
                widget._company,
              ),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new CompanyScreenBody(widget._company),
              ),
              new FriendShowcase(widget._company),
            ],
          ),
        ),
      ),
    );
  }
}
