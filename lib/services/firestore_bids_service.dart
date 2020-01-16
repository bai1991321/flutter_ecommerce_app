import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/model/bid.dart';

final CollectionReference bidsCollection =
    Firestore.instance.collection('bids');

class FirebaseFirestoreServiceBids {
  static final FirebaseFirestoreServiceBids _instance =
      new FirebaseFirestoreServiceBids.internal();

  factory FirebaseFirestoreServiceBids() => _instance;

  FirebaseFirestoreServiceBids.internal();

  Future<Bid> createBid(
      String id,
      String uid,
      String askID,
      String askProductID,
      String buyerID,
      String bidTitle,
      String quantity,
      String amount,
      String imgaeUrl,
      String productId) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(bidsCollection.document(id));

      final Bid bid = new Bid(
          id,
          uid,
          askID,
          askProductID,
          buyerID,
          bidTitle,
          amount,
          quantity,
          imgaeUrl,
          "active",
          new DateTime.now().toString().split(".")[0],
          new DateTime.now().toString().split(".")[0],
          productId);
      print(bid.toMap());
      final Map<String, dynamic> data = bid.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Bid.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getBidList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = bidsCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getBidByID(String id) {
    return bidsCollection.where("id", isEqualTo: id).snapshots();
  }

  Stream<QuerySnapshot> getBidListBybID(String sid, String whereclause) {
    return bidsCollection
        .where("buyerID", isEqualTo: sid)
        .where("status", isEqualTo: whereclause)
        .snapshots();
  }

  Stream<QuerySnapshot> getBidBypID(String pid) {
    return bidsCollection.where("askProductID", isEqualTo: pid).snapshots();
  }

  Stream<QuerySnapshot> getBidBypAskID(String aid) {
    return bidsCollection.where("askID", isEqualTo: aid).snapshots();
  }

  Stream<QuerySnapshot> getBidByUandPid(String uid, String pid) {
    return bidsCollection
        .where('authid', isEqualTo: uid)
        .where("askProductID", isEqualTo: pid)
        .snapshots();
  }

  Stream<QuerySnapshot> getBidListByuID(String uid, String whereclause) {
    return bidsCollection
        .where("authid", isEqualTo: uid)
        .where("status", isEqualTo: whereclause)
        .snapshots();
  }

  Future<dynamic> updateBid(Bid bid) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(bidsCollection.document(bid.id));
      bid.setUpdateDate(new DateTime.now().toString().split(".")[0]);
      await tx.update(ds.reference, bid.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteBid(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(bidsCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}
