import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/firebase_shippo_service.dart';
import 'package:flutter_ecommerce/utils/util.dart';

import './../services/transactions/retieve.dart';
import '../models/transactions/transaction.dart';
import 'ship_tracking_fragment.dart';
import 'package:intl/intl.dart';

class ShippoMainScreen extends StatefulWidget {
  _ShippoMainScreenState createState() => _ShippoMainScreenState();
}

class _ShippoMainScreenState extends State<ShippoMainScreen> {
  FirebaseShippoService shippodb = FirebaseShippoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shippo Status'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: shippodb.getShippo(Util.uid, "transactions"),
        builder: (ctx, snp) {
          switch (snp.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );

            default:
              if (snp.data.documents.length < 1)
                return Center(
                  child: Text(
                    "There is no Transaction.",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              return ListView.builder(
                itemCount: snp.data.documents.length,
                itemBuilder: (ctx, index) {
                  return FutureBuilder(
                    future: fetchTransactionRetrieve(
                        snp.data.documents[index].documentID),
                    builder: (context, trans) {
                      switch (trans.connectionState) {
                        case ConnectionState.waiting:
                          return Text('loading....');
                          break;
                        default:
                          return new Card(
                            child: ListTile(
                              title: Text(trans.data.metadata),
                              subtitle: Text(
                                  "Created at ${DateFormat.yMMMd().format(DateTime.parse(trans.data.object_created.split(".")[0].replaceAll(' ', 'T').replaceAll(':', '').replaceAll('-', '')))}"),
                              trailing: Text(trans.data.status),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShipTrackingFragment(trans.data)));
                              },
                            ),
                          );
                      }
                    },
                  );
                  Transactions m =
                      Transactions.fromMap(snp.data.documents[index].data);
                },
              );
          }
        },
      ),
    );
  }
}
