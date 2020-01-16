import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/model/category.dart';

final CollectionReference categoriesCollection =
    Firestore.instance.collection('categories');

class FirebaseFirestoreServiceCategory {
  static final FirebaseFirestoreServiceCategory _instance =
      new FirebaseFirestoreServiceCategory.internal();

  factory FirebaseFirestoreServiceCategory() => _instance;

  FirebaseFirestoreServiceCategory.internal();

  Future<Category> createCategory(
    String id,
    String name,
    String icon,
  ) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(categoriesCollection.document(id));

      final Category category = new Category(
        id,
        name,
        icon,
      );
      print(category.toMap());
      final Map<String, dynamic> data = category.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Category.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getCategoryList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = categoriesCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Stream<QuerySnapshot> getCategoryByID(String id) {
    return categoriesCollection.where("id", isEqualTo: id).snapshots();
  }

  Stream<QuerySnapshot> getSubCategoryList(String id) {
    return categoriesCollection.document(id).collection(id).snapshots();
  }

  Stream<DocumentSnapshot> getSubCategoryByID(String cid, String sid) {
    return categoriesCollection.document(cid).collection(cid).document(sid).snapshots();
  }

  Future<dynamic> updateCategory(Category category) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(categoriesCollection.document(category.id));

      await tx.update(ds.reference, category.toMap());
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
      final DocumentSnapshot ds =
          await tx.get(categoriesCollection.document(id));

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
