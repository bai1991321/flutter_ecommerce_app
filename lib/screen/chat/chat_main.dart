import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/bid.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/services/firestore_bids_service.dart';
import 'package:flutter_ecommerce/services/firestore_company_service.dart';
import 'package:flutter_ecommerce/utils/util.dart';

import 'chat_screen.dart';
import 'const.dart';

class ChatMainScreen extends StatefulWidget {
  @override
  State createState() => ChatMainScreenState();
}

class ChatMainScreenState extends State<ChatMainScreen> {
  FirebaseFirestoreServiceCompany db = FirebaseFirestoreServiceCompany();
  FirebaseFirestoreServiceBids dbBid = FirebaseFirestoreServiceBids();

  bool isLoading = false;

  


  Future<bool> onBackPress() {
    // openDialog();
    return Future.value(false);
  }

  Widget buildItem(BuildContext context, String id) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.getCompanyByID(id),
      builder: (ctx, snap) {
        switch (snap.connectionState) {
          case ConnectionState.waiting:
            return Text('loading...');
            break;
          default:
            Company company = Company.map(snap.data.documents[0]);
            return Container(
              child: FlatButton(
                child: Row(
                  children: <Widget>[
                    Material(
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(themeColor),
                              ),
                              width: 50.0,
                              height: 50.0,
                              padding: EdgeInsets.all(15.0),
                            ),
                        imageUrl: company.profile,
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      clipBehavior: Clip.hardEdge,
                    ),
                    Flexible(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Name: ${company.companyName}',
                                style: TextStyle(color: primaryColor),
                              ),
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                            ),
                            // Container(
                            //   child: Text(
                            //     'About me: ${document['aboutMe'] ?? 'Not available'}',
                            //     style: TextStyle(color: primaryColor),
                            //   ),
                            //   alignment: Alignment.centerLeft,
                            //   margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            // )
                          ],
                        ),
                        margin: EdgeInsets.only(left: 20.0),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Chat(
                                peerId: company.id,
                                peerAvatar: company.profile,
                              )));
                },
                color: Colors.grey[300],
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messaging',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: WillPopScope(
        child: Stack(
          children: <Widget>[
            // List
            Container(
              child: StreamBuilder<QuerySnapshot>(
                // stream: ,
                stream: Util.type == 'buyer'
                    ? dbBid.getBidListBybID(Util.uid, 'active')
                    : Firestore.instance
                        .collection('messages')
                        .where("supplier", isEqualTo: Util.uid)
                        .snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      ));
                    default:
                      List<String> data= [];
                      if (Util.type == 'buyer') {
                        data = snapshot.data.documents.map((f) => Bid.fromMap(f.data).authid).toList().toSet().toList();

                      }
                      return ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) => buildItem(
                            context,
                            //     Bid.map(snapshot.data.documents[index]).authid),
                            Util.type == 'buyer'
                                ? data[index]
                                : snapshot.data.documents[index]['buyer']),
                        itemCount:Util.type == 'buyer'? data.length: snapshot.data.documents.length,
                      );
                  }
                },
              ),
            ),

            // Loading
            Positioned(
              child: isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(themeColor)),
                      ),
                      color: Colors.white.withOpacity(0.8),
                    )
                  : Container(),
            )
          ],
        ),
        onWillPop: onBackPress,
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
