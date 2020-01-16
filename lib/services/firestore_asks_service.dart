import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/model/ask.dart';

final CollectionReference asksCollection =
    Firestore.instance.collection('asks');

class FirebaseFirestoreServiceAsks {
  static final FirebaseFirestoreServiceAsks _instance =
      new FirebaseFirestoreServiceAsks.internal();

  factory FirebaseFirestoreServiceAsks() => _instance;

  FirebaseFirestoreServiceAsks.internal();

  Future<Ask> createAsk(
    String id,
    String uid,
    String title,
    String description,
  ) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(asksCollection.document(id));

      final Ask ask = new Ask(
          id,
          uid,
          title,
          description,
          "active",
          new DateTime.now().toString().split(".")[0],
          new DateTime.now().toString().split(".")[0]);
      print(ask.toMap());
      final Map<String, dynamic> data = ask.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Ask.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getAskList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = asksCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getAskByID(String id) {
    return asksCollection.where("id", isEqualTo: id).snapshots();
  }

  Stream<QuerySnapshot> getAskListByuID(String uid, String whereclause) {
    return asksCollection
        .where("authid", isEqualTo: uid)
        .where("status", isEqualTo: whereclause)
        .snapshots();
  }

  Stream<QuerySnapshot> getAskActiveList() {
    return asksCollection.where("status", isEqualTo: "active").snapshots();
  }

  Future<dynamic> updateAsk(Ask ask) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(asksCollection.document(ask.id));
      ask.setUpdateDate(new DateTime.now().toString().split(".")[0]);
      await tx.update(ds.reference, ask.toMap());
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

  Future<dynamic> deleteAsk(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(asksCollection.document(id));

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
