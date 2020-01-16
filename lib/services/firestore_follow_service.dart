import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/model/follow.dart';

final CollectionReference followsCollection =
    Firestore.instance.collection('follows');

class FirebaseFirestoreServiceFollows {
  static final FirebaseFirestoreServiceFollows _instance =
      new FirebaseFirestoreServiceFollows.internal();

  factory FirebaseFirestoreServiceFollows() => _instance;

  FirebaseFirestoreServiceFollows.internal();

  Future<Follow> createFollow(String id, String uid, String productId,
      String supplierID, String starts, String description) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(followsCollection.document(id));

      final Follow follow = new Follow(
          id, uid, supplierID, new DateTime.now().toString().split(".")[0]);
      print(follow.toMap());
      final Map<String, dynamic> data = follow.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Follow.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getFollowList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = followsCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getfollowByID(String id) {
    return followsCollection.where("id", isEqualTo: id).snapshots();
  }

  Stream<QuerySnapshot> getfollowListBysID(String sid) {
    return followsCollection.where("supplierID", isEqualTo: sid).snapshots();
  }

  Stream<QuerySnapshot> getfollowListByuID(String uid) {
    return followsCollection.where("buyerID", isEqualTo: uid).snapshots();
  }

  Future<dynamic> updatefollow(Follow follow) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(followsCollection.document(follow.id));

      await tx.update(ds.reference, follow.toMap());
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
      final DocumentSnapshot ds = await tx.get(followsCollection.document(id));

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
