import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import './../models/tracking/tracking.dart';
import './../models/transactions/transaction.dart';
import './../services/tracking/get.dart';
import 'label_view_fragment.dart';

class ShipTrackingFragment extends StatelessWidget {
  Transactions _transactions;

  ShipTrackingFragment(this._transactions);

//   _ShipTrackingFragmentState createState() => _ShipTrackingFragmentState();
// }
  String pathPDF = "";

// class _ShipTrackingFragmentState extends State<ShipTrackingFragment> {

  bajarArchivo() async {
    final filename = "${_transactions.metadata}.pdf";
    var request = await HttpClient().getUrl(Uri.parse(_transactions.label_url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    pathPDF = file.path;
    return file;
  }

  @override
  Widget build(BuildContext context) {
    bajarArchivo();
    return Scaffold(
      appBar: AppBar(
        title: Text(_transactions.metadata),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LabelViewFragment(
                            pathPDF,
                          )));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: fetchTrackingRetrieve("usps", _transactions.tracking_number),
        builder: (context, snap) {
          switch (snap.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              return _widgetBuilder(Tracking.map(snap.data));
          }
        },
      ),
    );
  }

  Widget _widgetBuilder(Tracking _tracking) {
    if (_tracking.carrier == null) {
      return Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(),
            ),
            Text(
              "usps is not a valid test tracking carrier. Please use 'shippo'",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Divider(
              height: 20,
              color: Colors.white,
            ),
            GestureDetector(
              child: Text(
                "Click Here!",
                style: TextStyle(fontSize: 20, color: Colors.blue[300]),
              ),
              onTap: () {
                launcher.launch(_transactions.tracking_url_provider);
              },
            ),
            Expanded(
              child: SizedBox(),
            )
          ],
        ),
      );
    } else
      return ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Text(
                  _tracking.carrier,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          Card(
            child: Row(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Text(
                      "Address from",
                      style: TextStyle(color: Colors.grey),
                    ),
                    new Text(_tracking.address_from.city),
                    new Text(
                        "${_tracking.address_from.state} ${_tracking.address_from.zip} ${_tracking.address_from.country}"),
                  ],
                )
              ],
            ),
          )
        ],
      );
  }
}
