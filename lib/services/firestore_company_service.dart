import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/model/company.dart';

final CollectionReference companyCollection =
    Firestore.instance.collection('companies');

class FirebaseFirestoreServiceCompany {
  static final FirebaseFirestoreServiceCompany _instance =
      new FirebaseFirestoreServiceCompany.internal();

  factory FirebaseFirestoreServiceCompany() => _instance;

  FirebaseFirestoreServiceCompany.internal();

  Future<Company> createCompany(String uid, String name, String description,
      String profile, String type) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(companyCollection.document(uid));

      final Company company =
          new Company(uid, name, description, profile, type);
      print(company.toMap());
      final Map<String, dynamic> data = company.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Company.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getCompanyList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = companyCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getCompanyByID(String uid) {
    return companyCollection.where("authid", isEqualTo: uid).snapshots();
  }

  Future<dynamic> updateCompany(Company company) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(companyCollection.document(company.id));

      await tx.update(ds.reference, company.toMap());
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

  Future<dynamic> deleteCompany(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(companyCollection.document(id));

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
