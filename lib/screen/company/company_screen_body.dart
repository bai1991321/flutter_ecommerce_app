import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/screen/google-map/map_screen.dart';
import 'package:flutter_ecommerce/services/firebase_shippo_service.dart';
import 'package:flutter_ecommerce/utils/util.dart';

import './address/add_screen.dart';
import '../../flutter-shippo/models/addresses/address.dart';

// import 'package:location/location.dart';
// import 'package:flutter_places_dialog/flutter_places_dialog.dart';

class CompanyScreenBody extends StatefulWidget {
  final Company _company;

  CompanyScreenBody(this._company);

  _CompanyScreenBodyState createState() => _CompanyScreenBodyState();
}

class _CompanyScreenBodyState extends State<CompanyScreenBody> {
  var currentLocation = <String, double>{};

// var location = new Location();

// Platform messages may fail, so we use a try/catch PlatformException.

  void initState() {
    super.initState();
    // location.getLocation().then((onValue) => currentLocation = onValue);
  }

  Widget _buildLocationInfo(TextTheme textTheme) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Icon(
              Icons.place,
              color: Colors.white,
              size: 16.0,
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: new Text(
                "Company location",
                style: textTheme.subhead.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        new Container(
            height: 165.0,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseShippoService().getShippo(
                Util.uid,
                "addresses",
              ),
              builder: (ctx, snap) {
                switch (snap.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snap.data.documents.length + 1,
                      itemBuilder: (con, index) {
                        if (index == 0)
                          return _createAddressPlus();
                        else
                          return _createAddressCard(
                              snap.data.documents[index - 1]);
                      },
                    );
                }
              },
            )),
      ],
    );
  }

  Widget _createAddressPlus() {
    return new Container(
      height: 165.0,
      width: 56.0,
      child: Card(
        elevation: 3.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              alignment: Alignment.center,
              child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => AddAddressScreen()))),
            )
          ],
        ),
      ),
    );
  }

  Widget _createAddressCard(dynamic obj) {
    Address address = Address.map(obj);
    return new Container(
      height: 130.0,
      width: 200.0,
      margin: EdgeInsets.all(7.0),
      child: Card(
        elevation: 3.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Container(
                  width: 180,
                  margin: EdgeInsets.only(
                      left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(address.name,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade),
                      _verticalDivider(),
                      new Text(address.street1,
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 13.0,
                              letterSpacing: 0.5),
                          overflow: TextOverflow.ellipsis),
                      _verticalDivider(),
                      new Text(
                        address.city,
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 13.0,
                            letterSpacing: 0.5),
                      ),
                      _verticalDivider(),
                      new Text(
                        ' ${address.state} ${address.zip}',
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 13.0,
                            letterSpacing: 0.5),
                      ),
                      new Container(
                        margin: EdgeInsets.only(
                            left: 00.0, top: 05.0, right: 0.0, bottom: 5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              'Delivery Address',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black12,
                              ),
                            ),
                            _verticalD(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _createCircleBadge(IconData iconData, Color color) {
    return new Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: new CircleAvatar(
        backgroundColor: color,
        child: new Icon(
          iconData,
          color: Colors.white,
          size: 16.0,
        ),
        radius: 16.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          widget._company.companyName,
          style: textTheme.headline.copyWith(color: Colors.white),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: _buildLocationInfo(textTheme),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: new Text(
            widget._company.description,
            style:
                textTheme.body1.copyWith(color: Colors.white70, fontSize: 16.0),
          ),
        ),
        // new Padding(
        //   padding: const EdgeInsets.only(top: 16.0),
        //   child: new Row(
        //     children: <Widget>[
        //       _createCircleBadge(Icons.beach_access, theme.accentColor),
        //       _createCircleBadge(Icons.cloud, Colors.white12),
        //       _createCircleBadge(Icons.shop, Colors.white12),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  _addAddress() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => MapsScreen(),
    ));
  }
}
