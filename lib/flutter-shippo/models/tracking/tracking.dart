import '../addresses/address.dart';

class Tracking {
  String _carrier;
  String _tracking_number;
  Address _address_from;
  Address _address_to;
  String _transaction;
  String _eta;
  String _original_eta;
  String _servicelevel;
  TrackingStatus _tracking_status;
  String _tracking_history;
  String _metadata;

  Tracking({
    String carrier,
    String tracking_number,
    Address address_from,
    Address address_to,
    String transaction,
    String eta,
    String original_eta,
    String servicelevel,
    TrackingStatus tracking_status,
    String tracking_history,
    String metadata,
  }) {
    this._carrier = carrier;
    this._tracking_number = tracking_number;
    this._address_from = address_from;
    this._address_to = address_to;
    this._transaction = transaction;
    this._eta = eta;
    this._original_eta = original_eta;
    this._servicelevel = servicelevel;
    this._tracking_status = tracking_status;
    this._tracking_history = tracking_history;
    this._metadata = metadata;
  }

  String get carrier => this._carrier;

  String get tracking_number => this._tracking_number;

  Address get address_from => this._address_from;

  Address get address_to => this._address_to;

  String get transaction => this._transaction;

  String get eta => this._eta;

  String get original_eta => this._original_eta;

  String get servicelevel => this._servicelevel;

  TrackingStatus get tracking_status => this.tracking_status;

  String get tracking_history => this._tracking_history;

  String get metadata => this._metadata;

  Tracking.fromMap(Map<String, dynamic> obj) {
    this._carrier = obj['carrier'];
    this._tracking_number = obj['tracking_number'];
    this._address_from = obj['address_from'];
    this._address_to = obj['address_to'];
    this._transaction = obj['transaction'];
    this._eta = obj['eta'];
    this._original_eta = obj['original_eta'];
    this._servicelevel = obj['servicelevel'];
    this._tracking_status = obj['tracking_status'];
    this._tracking_history = obj['tracking_history'];
    this._metadata = obj['metadata'];
  }

  Tracking.map(dynamic obj) {
    if (obj == null) return;
    this._carrier = obj['carrier'];
    this._tracking_number = obj['tracking_number'];
    this._address_from = obj['address_from'];
    this._address_to = obj['address_to'];
    this._transaction = obj['transaction'];
    this._eta = obj['eta'];
    this._original_eta = obj['original_eta'];
    this._servicelevel = obj['servicelevel'];
    this._tracking_status = obj['tracking_status'];
    this._tracking_history = obj['tracking_history'];
    this._metadata = obj['metadata'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._carrier != null) map['carrier'] = this._carrier;
    if (this._tracking_number != null)
      map['tracking_number'] = this._tracking_number;
    if (this._address_from != null) map['address_from'] = this._address_from;
    if (this._address_to != null) map['address_to'] = this._address_to;
    if (this._transaction != null) map['transaction'] = this._transaction;
    if (this._eta != null) map['eta'] = this._eta;
    if (this._original_eta != null) map['original_eta'] = this._original_eta;
    if (this._servicelevel != null) map['servicelevel'] = this._servicelevel;
    if (this._tracking_status != null)
      map['tracking_status'] = this._tracking_status;
    if (this._tracking_history != null)
      map['tracking_history'] = this._tracking_history;
    if (this._metadata != null) map['metadata'] = this._metadata;

    return map;
  }
}

class TrackingStatus {
  String _status;
  String _status_details;
  String _status_date;
  Address _location;

  TrackingStatus({
    String status,
    String status_details,
    String status_date,
    Address location,
  }) {
    this._status = status;
    this._status_details = status_details;
    this._status_date = status_date;
    this._location = location;
  }

  String get status => this._status;

  String get status_details => this._status_details;

  String get status_date => this._status_date;

  Address get location => this._location;

  TrackingStatus.fromMap(Map<String, dynamic> obj) {
    this._status = obj['status'];
    this._status_details = obj['status_details'];
    this._status_date = obj['status_date'];
    this._location = Address.map(obj['location']);
  }

  TrackingStatus.map(dynamic obj) {
    this._status = obj['status'];
    this._status_details = obj['status_details'];
    this._status_date = obj['status_date'];
    this._location = Address.map(obj['location']);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._status != null) map['status'] = this._status;
    if (this._status_details != null)
      map['status_details'] = this._status_details;
    if (this._status_date != null) map['status_date'] = this._status_date;
    if (this._location != null) map['location'] = this._location.toMap();

    return map;
  }
}
