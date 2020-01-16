class CarrierAccount {
  String _object_id;
  String _object_owner;
  String _carrier;
  String _account_id;
  String _parameters;
  bool _test;
  bool _active;

  CarrierAccount({
    String object_id,
    String object_owner,
    String carrier,
    String account_id,
    String parameters,
    bool test,
    bool active,
  }) {
    this._object_id = object_id;
    this._object_owner = object_owner;
    this._carrier = carrier;
    this._account_id = account_id;
    this._parameters = parameters;
    this._test = test;
    this._active = active;
  }

  String get object_id => this._object_id;

  String get object_owner => this.object_owner;

  String get carrier => this._carrier;

  String get account_id => this._account_id;

  String get parameters => this._parameters;

  bool get test => this._test;

  bool get active => this._active;

  CarrierAccount.fromMap(Map<String, dynamic> obj) {
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._carrier = obj['carrier'];
    this._account_id = obj['account_id'];
    this._parameters = obj['parameters'];
    this._test = obj['test'];
    this._active = obj['active'];
  }

  CarrierAccount.map(dynamic obj) {
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._carrier = obj['carrier'];
    this._account_id = obj['account_id'];
    this._parameters = obj['parameters'];
    this._test = obj['test'];
    this._active = obj['active'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (this._object_id != null) map['object_id'] = this._object_id;
    if (this._object_owner != null) map['object_owner'] = this._object_owner;
    if (this._carrier != null) map['carrier'] = this._carrier;
    if (this._account_id != null) map['account_id'] = this._account_id;
    if (this._parameters != null) map['parameters'] = this._parameters;
    if (this._test != null) map['test'] = this._test;
    if (this._active != null) map['active'] = this._active;

    return map;
  }
}

class CarrierAccountBody {
  String _carrier;
  String _account_id;
  String _parameters;
  bool _active;

  CarrierAccountBody({
    String carrier,
    String account_id,
    String parameters,
    bool active,
  }) {
    this._carrier = carrier;
    this._account_id = account_id;
    this._parameters = parameters;
    this._active = active;
  }

  String get carrier => this._carrier;

  String get account_id => this._account_id;

  String get parameters => this._parameters;

  bool get active => this._active;

  CarrierAccountBody.fromMap(Map<String, dynamic> obj) {
    this._carrier = obj['carrier'];
    this._account_id = obj['account_id'];
    this._parameters = obj['parameters'];
    this._active = obj['active'];
  }

  CarrierAccountBody.map(dynamic obj) {
    this._carrier = obj['carrier'];
    this._account_id = obj['account_id'];
    this._parameters = obj['parameters'];
    this._active = obj['active'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (this._carrier != null) map['carrier'] = this._carrier;
    if (this._account_id != null) map['account_id'] = this._account_id;
    if (this._parameters != null) map['parameters'] = this._parameters;
    if (this._active != null) map['active'] = this._active;

    return map;
  }
}
