import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/model/ask_product.dart';
import 'package:flutter_ecommerce/utils/util.dart';

final CollectionReference askProductsCollection =
    Firestore.instance.collection('ask_products');

class FirebaseFirestoreServiceAskProducts {
  static final FirebaseFirestoreServiceAskProducts _instance =
      new FirebaseFirestoreServiceAskProducts.internal();

  factory FirebaseFirestoreServiceAskProducts() => _instance;

  FirebaseFirestoreServiceAskProducts.internal();

  Future<AskProduct> createAskProduct(
      String id,
      String askId,
      String product_name,
      String quantity,
      String specification,
      String description,
      String delivery_date,
      String budget) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(askProductsCollection.document(id));

      final AskProduct askProduct = new AskProduct(
          id,
          askId,
          Util.uid,
          product_name,
          quantity,
          specification,
          description,
          delivery_date,
          budget);
      print(askProduct.toMap());
      final Map<String, dynamic> data = askProduct.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return AskProduct.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getAskProductsList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = askProductsCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getAskProductByID(String id) {
    return askProductsCollection.where("id", isEqualTo: id).snapshots();
  }

  Stream<QuerySnapshot> getAskProcutsListByaID(
    String aid,
  ) {
    return askProductsCollection.where("askId", isEqualTo: aid).snapshots();
  }

  Future<dynamic> updateAskProduct(AskProduct askProduct) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(askProductsCollection.document(askProduct.id));
      await tx.update(ds.reference, askProduct.toMap());
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
      final DocumentSnapshot ds =
          await tx.get(askProductsCollection.document(id));

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
