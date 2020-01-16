import '../message.dart';

class Transactions {
  String _object_state;
  String _status;
  String _object_created;
  String _object_updated;
  String _object_id;
  String _object_owner;
  String _rate;
  String _metadata;
  String _label_file_type;
  bool _test;
  String _tracking_number;
  String _tracking_status;
  String _tracking_url_provider;
  String _eta;
  String _label_url;
  String _commercial_invoice_url;
  List<Message> _messages;

  Transactions({
    String object_state,
    String status,
    String object_created,
    String object_updated,
    String object_id,
    String object_owner,
    String rate,
    String metadata,
    String label_file_type,
    bool test,
    String tracking_number,
    String tracking_status,
    String tracking_url_provider,
    String eta,
    String label_url,
    String commercial_invoice_url,
    List<Message> messages,
  }) {
    this._object_state = object_state;
    this._status = status;
    this._object_created = object_created;
    this._object_updated = object_updated;
    this._object_id = object_id;
    this._object_owner = object_owner;
    this._rate = rate;
    this._metadata = metadata;
    this._label_file_type = label_file_type;
    this._test = test;
    this._tracking_number = tracking_number;
    this._tracking_status = tracking_status;
    this._tracking_url_provider = tracking_url_provider;
    this._eta = eta;
    this._label_url = label_url;
    this._commercial_invoice_url = commercial_invoice_url;
    this._messages = messages;
  }

  String get object_state => this._object_state;

  String get status => this._status;

  String get object_created => this._object_created;

  String get object_updated => this._object_updated;

  String get object_id => this._object_id;

  String get object_owner => this._object_owner;

  String get rate => this._rate;

  String get metadata => this._metadata;

  String get label_file_type => this._label_file_type;

  bool get test => this._test;

  String get tracking_number => this._tracking_number;

  String get tracking_status => this._tracking_status;

  String get tracking_url_provider => this._tracking_url_provider;

  String get eta => this._eta;

  String get label_url => this._label_url;

  String get commercial_invoice_url => this._label_url;

  List<Message> get messages => this._messages;

  Transactions.fromMap(Map<String, dynamic> obj) {
    this._object_state = obj['object_state'];
    this._status = obj['status'];
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._rate = obj['rate'];
    this._metadata = obj['metadata'];
    this._label_file_type = obj['label_file_type'];
    this._test = obj['test'];
    this._tracking_number = obj['tracking_number'];
    this._tracking_status = obj['tracking_status'];
    this._tracking_url_provider = obj['tracking_url_provider'];
    this._eta = obj['eta'];
    this._label_url = obj['label_url'];
    this._commercial_invoice_url = obj['commercial_invoice_url'];
    this._messages =
        (obj['messages'] as List).map((e) => Message.map(e)).toList();
  }

  Transactions.map(dynamic obj) {
    this._object_state = obj['object_state'];
    this._status = obj['status'];
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._rate = obj['rate'];
    this._metadata = obj['metadata'];
    this._label_file_type = obj['label_file_type'];
    this._test = obj['test'];
    this._tracking_number = obj['tracking_number'];
    this._tracking_status = obj['tracking_status'];
    this._tracking_url_provider = obj['tracking_url_provider'];
    this._eta = obj['eta'];
    this._label_url = obj['label_url'];
    this._commercial_invoice_url = obj['commercial_invoice_url'];
    this._messages =
        (obj['messages'] as List).map((e) => Message.map(e)).toList();
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._object_state != null) map['object_state'] = this._object_state;
    if (this._object_created != null)
      map['object_created'] = this._object_created;
    if (this._status != null) map['status'] = this._status;
    if (this._object_updated != null)
      map['object_updated'] = this._object_updated;
    if (this._object_id != null) map['object_id'] = this._object_id;
    if (this._object_owner != null) map['object_owner'] = this._object_owner;
    if (this._rate != null) map['rate'] = this._rate;
    if (this._metadata != null) map['metadata'] = this._metadata;
    if (this._label_file_type != null)
      map['label_file_type'] = this._label_file_type;
    if (this._test != null) map['test'] = this._test;
    if (this._tracking_number != null)
      map['tracking_number'] = this._tracking_number;
    if (this._tracking_status != null)
      map['tracking_status'] = this._tracking_status;
    if (this._tracking_url_provider != null)
      map['tracking_url_provider'] = this._tracking_url_provider;
    if (this._eta != null) map['eta'] = this._eta;
    if (this._label_url != null) map['label_url'] = this._label_url;
    if (this._commercial_invoice_url != null)
      map['commercial_invoice_url'] = this._commercial_invoice_url;
    if (this._messages != null)
      map['messages'] = this._messages.map((f) => f.toMap()).toList();
    return map;
  }
}
