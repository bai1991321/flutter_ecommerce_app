class Address {
  bool _is_complete;
  String _object_created;
  String _object_updated;
  String _object_id;
  String _object_owner;
  String _name;
  String _company;
  String _street_no;
  String _street1;
  String _street2;
  String _street3;
  String _city;
  String _state;
  String _zip;
  String _country;
  String _phone;
  String _email;
  bool _is_residential;
  String _validate;
  String _metadata;
  bool _test;
  ValidationResults _validation_results;

  Address(
      {bool is_complete,
      String object_created,
      String object_updated,
      String object_id,
      String object_owner,
      String name,
      String company,
      String street_no,
      String street1,
      String street2,
      String street3,
      String city,
      String state,
      String zip,
      String country,
      String phone,
      String email,
      bool is_residential,
      String validate,
      String metadata,
      bool test,
      ValidationResults validation_results}) {
    this._is_complete = is_complete;
    this._object_created = object_created;
    this._object_updated = object_updated;
    this._object_id = object_id;
    this._object_owner = object_owner;
    this._name = name;
    this._company = company;
    this._street1 = street1;
    this._street2 = street2;
    this._street3 = street3;
    this._street_no = street_no;
    this._city = city;
    this._zip = zip;
    this._state = state;
    this._country = country;
    this._phone = phone;
    this._is_residential = is_residential;
    this._validate = validate;
    this._metadata = metadata;
    this._test = test;
    this._validation_results = validation_results;
  }

  Address.map(dynamic obj) {
    this._is_complete = obj['is_complete'];
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_ovner'];
    this._name = obj['name'];
    this._company = obj['company'];
    this._street_no = obj['street_no'];
    this._street1 = obj['street1'];
    this._street2 = obj['street2'];
    this._street3 = obj['street3'];
    this._city = obj['city'];
    this._state = obj['state'];
    this._zip = obj['zip'];
    this._country = obj['country'];
    this._phone = obj['phone'];
    this._email = obj['email'];
    this._is_residential = obj['is_residential'];
    this._validate = obj['validate'];
    this._metadata = obj['metadata'];
    this._test = obj['test'];
    if (obj['validation_results'] != null)
      this._validation_results =
          ValidationResults.map(obj['validation_results']);
  }

  bool get is_complete => this._is_complete;

  String get object_created => this._object_created ?? '';

  String get object_updated => this._object_updated ?? '';

  String get object_id => this._object_id ?? '';

  String get object_owner => this._object_owner ?? '';

  String get name => this._name ?? '';

  String get street1 => this._street1 ?? '';

  String get street2 => this._street2 ?? '';

  String get street3 => this._street3 ?? '';

  String get street_no => this._street_no ?? '';

  String get city => this._city ?? '';

  String get state => this._state ?? '';

  String get zip => this._zip ?? '';

  String get country => this._country ?? '';

  String get phone => this._phone ?? '';

  String get email => this._email ?? '';

  bool get is_residential => this._is_residential;

  String get metadata => this._metadata ?? '';

  bool get test => this._test;

  ValidationResults get validation_results => this._validation_results ?? '';

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (this._is_complete != null) map['is_complete'] = this._is_complete;
    if (this._object_created != null)
      map['object_created'] = this._object_created;
    if (this._object_updated != null)
      map['object_updated'] = this._object_updated;
    if (this._object_id != null) map['object_id'] = this._object_id;
    if (this._object_owner != null) map['object_owner'] = this._object_owner;
    if (this._name != null) map['name'] = this._name;
    if (this._street1 != null) map['street1'] = this._street1;
    if (this._street2 != null) map['street2'] = this._street2;
    if (this._street3 != null) map['street3'] = this._street3;
    if (this._street_no != null) map['street_no'] = this._street_no;
    if (this._city != null) map['city'] = this._city;
    if (this._state != null) map['state'] = this._state;
    if (this._zip != null) map['zip'] = this._zip;
    if (this._country != null) map['country'] = this._country;
    if (this._phone != null) map['phone'] = this._phone;
    if (this._email != null) map['email'] = this._email;
    if (this._is_residential != null)
      map['is_residential'] = this._is_residential;
    if (this._metadata != null) map['metadata'] = this._metadata;
    map['test'] = this._test;
    // if (this._validation_results != null) map['validation_results'] = this._validation_results.toMap();
    return map;
  }

  Address.fromMap(Map<String, dynamic> obj) {
    this._is_complete = obj['is_complete'];
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_ovner'];
    this._company = obj['company'];
    this._street_no = obj['street_no'];
    this._name = obj['name'];
    this._street1 = obj['street1'];
    this._street2 = obj['street2'];
    this._street3 = obj['street3'];
    this._city = obj['city'];
    this._state = obj['state'];
    this._zip = obj['zip'];
    this._country = obj['country'];
    this._phone = obj['phone'];
    this._email = obj['email'];
    this._is_residential = obj['is_residential'];
    // this._validate = obj['validate'];
    this._metadata = obj['metadata'];
    this._test = obj['test'];
    if (obj['validation_results'] != null)
      this._validation_results =
          ValidationResults.map(obj['validation_results']);
  }
}

class ValidationResults {
  bool _is_valid;
  List<ValidationMessage> _validationMessages;

  ValidationResults(this._is_valid, this._validationMessages);

  ValidationResults.map(dynamic obj) {
    this._is_valid = obj['is_valid'];
    if (obj['messages'] != null)
      this._validationMessages = (obj['messages'] as List)
          .map((m) => ValidationMessage.map(m))
          .toList();
  }

  ValidationResults.fromMap(Map<String, dynamic> obj) {
    this._is_valid = obj['is_valid'];
    this._validationMessages =
        (obj['messages'] as List).map((m) => ValidationMessage.map(m)).toList();
  }

  bool get is_valid => this._is_valid;

  List<ValidationMessage> get messages => this._validationMessages;
}

class ValidationMessage {
  String _source;
  String _code;
  String _text;

  ValidationMessage(this._source, this._code, this._text);

  String get source => this._source ?? '';

  String get code => this._code ?? '';

  String get text => this._text ?? '';

  ValidationMessage.map(dynamic obj) {
    this._source = obj['source'];
    this._code = obj['code'];
    this._text = obj['text'];
  }

  ValidationMessage.fromMap(Map<String, dynamic> obj) {
    this._source = obj['source'];
    this._code = obj['code'];
    this._text = obj['text'];
  }
}
