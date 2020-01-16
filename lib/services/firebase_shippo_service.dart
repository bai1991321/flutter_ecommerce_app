import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference productCollection =
    Firestore.instance.collection('shippo');

class FirebaseShippoService {
  static final FirebaseShippoService _instance =
      new FirebaseShippoService.internal();

  factory FirebaseShippoService() => _instance;

  FirebaseShippoService.internal();

  Future<Map<String, dynamic>> createShippo(
      String uid, String col_name, String id, Map<String, dynamic> data) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(
          productCollection.document(uid).collection(col_name).document(id));

      print(data);
      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return mapData;
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getShippo(String uid, String col_name) {
    Stream<QuerySnapshot> snapshots =
        productCollection.document(uid).collection(col_name).snapshots();
    return snapshots;
  }

  Stream<dynamic> getShippoID(String uid, String col_name, String id) {
    return productCollection
        .document(uid)
        .collection(col_name)
        .document(id)
        .snapshots()
        .asyncMap((convert) => convert.data);
  }

  Future<dynamic> updateShippo(
      String uid, String col_name, String id, dynamic data) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(
          productCollection.document(uid).collection(col_name).document(id));

      await tx.update(ds.reference, data);
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

  Future<dynamic> deleteShippo(String uid, String col_name, String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(
          productCollection.document(uid).collection(col_name).document(id));

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
