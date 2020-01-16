import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/services/firestore_asks_service.dart';
import 'package:flutter_ecommerce/services/firestore_company_service.dart';import 'asks_view_page.dart';

class AllAskListPage extends StatefulWidget {
  _AllAskListPageState createState() => _AllAskListPageState();
}

class _AllAskListPageState extends State<AllAskListPage> {
  FirebaseFirestoreServiceAsks db = FirebaseFirestoreServiceAsks();
  FirebaseFirestoreServiceCompany cdb = FirebaseFirestoreServiceCompany();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Asks"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.getAskActiveList(),
        builder: (ctx, snap) {
          switch (snap.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              return ListView.builder(
                itemCount: snap.data.documents.length,
                itemBuilder: (ctx, index) {
                  Ask ask = Ask.map(snap.data.documents[index]);
                  return Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: new ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      title: Text(
                        ask.ask_title,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: StreamBuilder<QuerySnapshot>(
                        stream: cdb.getCompanyByID(ask.authid),
                        builder: (cntx, snp) {
                          switch (snp.connectionState) {
                            case ConnectionState.waiting:
                              return Text("Loading...");
                            default:
                              Company company =
                                  Company.map(snp.data.documents[0]);
                              return Text(company.companyName);
                          }
                        },
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.grey, size: 30.0),
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (ctx) => AskViewPage(ask: ask
                                        )));
                      },
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
