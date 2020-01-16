import '../message.dart';

class Manifest {
  String _object_created;
  String _object_updated;
  String _object_id;
  String _object_owner;
  String _status;
  List<Message> _errors;
  String _carrier_account;
  String _shipment_date;
  String _address_from;
  List<String> _transactions;
  List<String> _documents;

  Manifest({
    String object_created,
    String object_updated,
    String object_id,
    String object_owner,
    String status,
    List<Message> errors,
    String carrier_account,
    String shipment_date,
    String address_from,
    List<String> transactions,
    List<String> documents,
  }) {
    this._object_created = object_created;
    this._object_updated = object_updated;
    this._object_id = object_id;
    this._object_owner = object_owner;
    this._status = status;
    this._errors = errors;
    this._carrier_account = carrier_account;
    this._shipment_date = shipment_date;
    this._address_from = address_from;
    this._transactions = transactions;
    this._documents = documents;
  }

  String get object_created => this._object_created ?? '';

  String get object_updated => this._object_updated ?? '';

  String get object_id => this._object_id ?? '';

  String get object_owner => this._object_owner ?? '';

  String get status => this._status;

  List<Message> get errors => this._errors;

  String get carrier_account => this._carrier_account;

  String get shipment_date => this._shipment_date;

  String get address_from => this._address_from;

  List<String> get transactions => this._transactions;

  List<String> get documents => this._documents;

  Manifest.fromMap(Map<String, dynamic> obj) {
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._status = obj['status'];
    this._errors = obj['errors'].map((e) => Message.map(e)).toList();
    this._carrier_account = obj['carrier_account'];
    this._shipment_date = obj['shipment_date'];
    this._address_from = obj['address_from'];
    this._transactions = obj['transactions'].map((e) => e).toList();
    this._documents = obj['documents'].map((e) => e).toList();
  }

  Manifest.map(dynamic obj) {
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._status = obj['status'];
    this._errors = obj['errors'].map((e) => Message.map(e)).toList();
    this._carrier_account = obj['carrier_account'];
    this._shipment_date = obj['shipment_date'];
    this._address_from = obj['address_from'];
    this._transactions = obj['transactions'].map((e) => e).toList();
    this._documents = obj['documents'].map((e) => e).toList();
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._object_created != null)
      map['object_created'] = this._object_created;
    if (this._object_updated != null)
      map['object_updated'] = this._object_updated;
    if (this._object_id != null) map['object_id'] = this._object_id;
    if (this._object_owner != null) map['object_owner'] = this._object_owner;
    if (this._status != null) map['status'] = this._status;
    if (this._errors != null)
      map['errors'] = this._errors.map((f) => f.toMap());
    if (this._carrier_account != null)
      map['carrier_account'] = this._carrier_account;
    if (this._shipment_date != null) map['shipment_date'] = this._shipment_date;
    if (this._address_from != null) map['address_from'] = this._address_from;
    if (this._transactions != null)
      map['transactions'] = this._transactions.map((f) => f);
    if (this._documents != null)
      map['documents'] = this._documents.map((f) => f);

      return map;
  }
}

class ManifestBody {
  String _carrier_account;
  String _shipment_date;
  String _address_from;
  List<String> _transactions;
  String _async;

  ManifestBody(
      {String carrier_account,
      String shipment_date,
      String address_from,
      List<String> transactions,
      String asyn}) {
    this._carrier_account = carrier_account;
    this._shipment_date = shipment_date;
    this._address_from = address_from;
    this._transactions = transactions;
    this._async = asyn;
  }

  String get carrier_account => this._carrier_account;

  String get shipment_date => this._shipment_date;

  String get address_from => this._address_from;

  List<String> get transactions => this._transactions;

  String get asyn => this._async;

  ManifestBody.fromMap(Map<String, dynamic> obj) {
    this._carrier_account = obj['carrier_account'];
    this._shipment_date = obj['shipment_date'];
    this._address_from = obj['address_from'];
    this._transactions = obj['transactions'].map((e) => e).toList();
    this._async = obj['async'];
  }

  ManifestBody.map(dynamic obj) {
    this._carrier_account = obj['carrier_account'];
    this._shipment_date = obj['shipment_date'];
    this._address_from = obj['address_from'];
    this._transactions = obj['transactions'].map((e) => e).toList();
    this._async = obj['async'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._carrier_account != null)
      map['carrier_account'] = this._carrier_account;
    if (this._shipment_date != null) map['shipment_date'] = this._shipment_date;
    if (this._address_from != null) map['address_from'] = this._address_from;
    if (this._transactions != null)
      map['transactions'] = this._transactions.map((f) => f);
    if (this._async != null) map['async'] = this._async;

    return map;
  }
}
