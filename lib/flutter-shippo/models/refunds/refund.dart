class Refund {
  String _object_created;
  String _object_updated;
  String _object_id;
  String _object_owner;
  String _status;
  String _transaction;
  String _test;

  String get object_created => this._object_created ?? '';

  String get object_updated => this._object_updated ?? '';

  String get object_id => this._object_id ?? '';

  String get object_owner => this._object_owner ?? '';

  String get status => this._status;

  String get transaction => this._transaction;

  String get test => this._test;

  Refund({
    String object_created,
    String object_updated,
    String object_id,
    String object_owner,
    String status,
    String transaction,
    String test,
  }) {
    this._object_created = object_created;
    this._object_updated = object_updated;
    this._object_id = object_id;
    this._object_owner = object_owner;
    this._status = status;
    this._transaction = transaction;
    this._test = test;
  }

  Refund.fromMap(Map<String, dynamic> obj) {
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._status = obj['status'];
    this._transaction = obj['transaction'];
    this._test = obj['test'];
  }

  Refund.map(dynamic obj) {
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._status = obj['status'];
    this._transaction = obj['transaction'];
    this._test = obj['test'];
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
    if (this._transaction != null) map['transaction'] = this._transaction;
    if (this._test != null) map['test'] = this._test;

    return map;
  }
}

class RefundBody {
  String _transaction;
  String _async;

  RefundBody(this._transaction, this._async);

  String get transaction => this._transaction;

  String get asyn => this._async;

  RefundBody.fromMap(Map<String, dynamic> obj) {
    this._transaction = obj['transaction'];
    this._async = obj['async'];
  }

  RefundBody.map(dynamic obj) {
    this._transaction = obj['transaction'];
    this._async = obj['async'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['transaction'] = this._transaction;
    if (this._async != null) map['async'] = this._async;

    return map;
  }
}
