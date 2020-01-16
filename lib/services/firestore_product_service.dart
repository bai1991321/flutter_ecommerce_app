import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/model/product.dart';

final CollectionReference productCollection =
    Firestore.instance.collection('products');

class FirebaseFirestoreServiceProduct {
  static final FirebaseFirestoreServiceProduct _instance =
      new FirebaseFirestoreServiceProduct.internal();

  factory FirebaseFirestoreServiceProduct() => _instance;

  FirebaseFirestoreServiceProduct.internal();

  Future<Product> createProduct(
      String id,
      String supplier,
      String itemname,
      String preprice,
      String price,
      String budge,
      String description,
      String category,
      String subcategory,
      String amount,
      String rating,
      String imageUrl,
      String distance_unit,
      String length,
      String width,
      String height,
      String mass_unit,
      String weight) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(productCollection.document(id));

      final Product product = new Product(
          id,
          supplier,
          itemname,
          preprice,
          price,
          budge,
          rating,
          description,
          category,
          subcategory,
          amount,
          [imageUrl],
          new DateTime.now().toString().split(".")[0],
          distance_unit,
          length,
          width,
          height,
          mass_unit,
          weight);
      final Map<String, dynamic> data = product.toMap();
      print(data);
      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Product.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getProductList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = productCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

   Stream<QuerySnapshot> getProductListByCategory(String id,{int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = productCollection.where("category", isEqualTo: id).snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

   Stream<QuerySnapshot> getProductListBySubcategory(String id,{int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = productCollection.where("subCategory", isEqualTo: id).snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getProductsListByID(
    String uid, {
    int offset,
    int limit,
  }) {
    Stream<QuerySnapshot> snapshots =
        productCollection.where("supplier", isEqualTo: uid).snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getProductByID(String pid) {
    return productCollection.where("id", isEqualTo: pid).snapshots();
  }

  Stream<QuerySnapshot> searchWithKey() {
    return productCollection.snapshots();
  }

  Future<dynamic> updateProduct(Product product) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(productCollection.document(product.id));

      await tx.update(ds.reference, product.toMap());
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

  Future<dynamic> deleteProduct(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(productCollection.document(id));

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
