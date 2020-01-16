import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/model/review.dart';

final CollectionReference reviewsCollection =
    Firestore.instance.collection('reviews');

class FirebaseFirestoreServiceReviews {
  static final FirebaseFirestoreServiceReviews _instance =
      new FirebaseFirestoreServiceReviews.internal();

  factory FirebaseFirestoreServiceReviews() => _instance;

  FirebaseFirestoreServiceReviews.internal();

  Future<Review> createReview(String id, String uid, String productId,
      String supplierID, String starts, String description) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(reviewsCollection.document(id));

      final Review review = new Review(id, uid, productId, supplierID, starts,
          description, new DateTime.now().toString().split(".")[0]);
      print(review.toMap());
      final Map<String, dynamic> data = review.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Review.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getReviewList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = reviewsCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getReviewByID(String id) {
    return reviewsCollection.where("id", isEqualTo: id).snapshots();
  }

  Stream<QuerySnapshot> getReviewListBysID(String sid) {
    return reviewsCollection.where("supplierID", isEqualTo: sid).snapshots();
  }

  Stream<QuerySnapshot> getReviewBypID(String pid) {
    return reviewsCollection.where("productID", isEqualTo: pid).snapshots();
  }

  Stream<QuerySnapshot> getReviewListByuID(String uid) {
    return reviewsCollection.where("buyerID", isEqualTo: uid).snapshots();
  }

  Future<dynamic> updateReview(Review review) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(reviewsCollection.document(review.id));

      await tx.update(ds.reference, review.toMap());
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
      final DocumentSnapshot ds = await tx.get(reviewsCollection.document(id));

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
