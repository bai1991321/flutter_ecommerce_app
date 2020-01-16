import '../message.dart';

class Rate {
  String _object_created;
  String _object_id;
  String _object_owner;
  List<String> _attributes;
  String _amount_local;
  String _currency_local;
  String _amount;
  String _currency;
  String _provider;
  String _provider_image_75;
  String _provider_image_200;
  ServiceLevel _servicelevel;
  int _estimated_days;
  String _duration_terms;
  String _carrier_account;
  String _zone;
  List<Message> _messages;
  bool _test;

  Rate(
      {String object_created,
      String object_id,
      String object_owner,
      List<String> attributes,
      String amount_local,
      String currency_local,
      String amount,
      String currency,
      String provider,
      String provider_image_75,
      String provider_image_200,
      ServiceLevel servicelevel,
      int estimated_days,
      String duration_terms,
      String carrier_account,
      String zone,
      List<Message> messages,
      bool test}) {
    this._object_created = object_created;
    this._object_id = object_id;
    this._object_owner = object_owner;
    this._attributes = attributes;
    this._amount_local = amount_local;
    this._currency_local = currency_local;
    this._amount = amount;
    this._currency = currency;
    this._provider = provider;
    this._provider_image_75 = provider_image_75;
    this._provider_image_200 = provider_image_200;
    this._servicelevel = servicelevel;
    this._estimated_days = estimated_days;
    this._duration_terms = duration_terms;
    this._carrier_account = carrier_account;
    this._zone = zone;
    this._messages = messages;
    this._test = test;
  }

  String get object_created => this._object_created;

  String get object_id => this._object_id;

  String get object_owner => this._object_owner;

  List<String> get attributes => this._attributes;

  String get amount_local => this._amount_local;

  String get currency_local => this._currency_local;

  String get amount => this._amount;

  String get currency => this._currency;

  String get provider => this._provider;

  String get provider_image_75 => this._provider_image_75;

  String get provider_image_200 => this._provider_image_200;

  ServiceLevel get servicelevel => this._servicelevel;

  int get estimated_days => this._estimated_days;

  String get duration_terms => this._duration_terms;

  String get carrier_account => this._carrier_account;

  String get zone => this._zone;

  List<Message> get messages => this._messages;

  bool get test => this._test;

  Rate.fromMap(Map<String, dynamic> obj) {
    this._object_created = obj['object_created'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._attributes =
        (obj['attributes'] as List).map((f) => f.toString()).toList();
    this._amount_local = obj['amount_local'];
    this._currency_local = obj['currency_local'];
    this._amount = obj['amount'];
    this._currency = obj['currency'];
    this._provider = obj['provider'];
    this._provider_image_75 = obj['provider_image_75'];
    this._provider_image_200 = obj['provider_image_200'];
    this._servicelevel = ServiceLevel.map(obj['servicelevel']);
    this._estimated_days = obj['estimated_days'];
    this._duration_terms = obj['duration_terms'];
    this._carrier_account = obj['carrier_account'];
    this._zone = obj['zone'];
    this._messages = obj['messages'].map((e) => Message.map(e)).toList();
    this._test = obj['test'];
  }

  Rate.map(dynamic obj) {
    this._object_created = obj['object_created'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._attributes =
        (obj['attributes'] as List).map((f) => f.toString()).toList();
    this._amount_local = obj['amount_local'];
    this._currency_local = obj['currency_local'];
    this._amount = obj['amount'];
    this._currency = obj['currency'];
    this._provider = obj['provider'];
    this._provider_image_75 = obj['provider_image_75'];
    this._provider_image_200 = obj['provider_image_200'];
    this._servicelevel = ServiceLevel.map(obj['servicelevel']);
    this._estimated_days = obj['estimated_days'];
    this._duration_terms = obj['duration_terms'];
    this._carrier_account = obj['carrier_account'];
    this._zone = obj['zone'];
    this._messages =
        (obj['messages'] as List).map((e) => Message.map(e)).toList();
    this._test = obj['test'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._object_created != null)
      map['object_created'] = this._object_created;
    if (this._object_id != null) map['object_id'] = this._object_id;
    if (this._object_owner != null) map['object_owner'] = this._object_owner;
    if (this._attributes != null)
      map['attributes'] = this._attributes.map((f) => f).toList();
    if (this._amount_local != null) map['amount_local'] = this._amount_local;
    if (this._currency_local != null)
      map['currency_local'] = this._currency_local;
    if (this._amount != null) map['amount'] = this._amount;
    if (this._currency != null) map['currency'] = this._currency;
    if (this._provider != null) map['provider'] = this._provider;
    if (this._provider_image_75 != null)
      map['provider_image_75'] = this._provider_image_75;
    if (this._provider_image_200 != null)
      map['provider_image_200'] = this._provider_image_200;
    if (this._servicelevel != null)
      map['servicelevel'] = this._servicelevel.toMap();
    if (this._estimated_days != null)
      map['estimated_days'] = this._estimated_days;
    if (this._duration_terms != null)
      map['duration_terms'] = this._duration_terms;
    if (this._carrier_account != null)
      map['carrier_account'] = this._carrier_account;
    if (this._zone != null) map['zone'] = this._zone;
    if (this._messages != null)
      map['messages'] = this._messages.map((f) => f.toMap()).toList();
    if (this._test != null) map['test'] = this._test;

    return map;
  }
}

class ServiceLevel {
  String _name;
  String _token;
  String _terms;

  ServiceLevel({String name, String token, String terms}) {
    this._name = name;
    this._terms = terms;
    this._token = token;
  }

  String get name => this._name;

  String get token => this._token;

  String get terms => this._terms;

  ServiceLevel.fromMap(Map<String, dynamic> obj) {
    this._name = obj['name'];
    this._token = obj['token'];
    this._terms = obj['terms'];
  }

  ServiceLevel.map(dynamic obj) {
    this._name = obj['name'];
    this._token = obj['token'];
    this._terms = obj['terms'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['name'] = this._name;
    map['token'] = this._token;
    map['terms'] = this._terms;

    return map;
  }
}
