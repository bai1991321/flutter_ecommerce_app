class CustomItem {
  String _object_state;
  String _object_created;
  String _object_updated;
  String _object_id;
  String _object_owner;
  String _description;
  String _quantity;
  String _net_weight;
  String _mass_unit;
  String _value_amount;
  String _value_currency;
  String _origin_country;
  String _tariff_number;
  String _sku_code;
  String _metadata;
  String _test;

  String get object_state => this._object_state ?? '';

  String get object_created => this._object_created ?? '';

  String get object_updated => this._object_updated ?? '';

  String get object_id => this._object_id ?? '';

  String get object_owner => this._object_owner ?? '';

  String get description => this._description ?? '';

  String get quantity => this._quantity ?? '';

  String get net_weight => this._net_weight ?? '';

  String get mass_unit => this._mass_unit ?? '';

  String get value_amount => this._value_amount ?? '';

  String get value_currency => this._value_currency ?? '';

  String get origin_country => this._origin_country ?? '';

  String get metadata => this._metadata ?? '';

  String get tariff_number => this._tariff_number ?? '';

  String get sku_code => this._sku_code;

  String get test => this._test ?? '';

  CustomItem({
    String object_state,
    String object_created,
    String object_updated,
    String object_id,
    String object_owner,
    String description,
    String quantity,
    String net_weight,
    String mass_unit,
    String value_amount,
    String value_currency,
    String origin_country,
    String tariff_number,
    String sku_code,
    String metadata,
    String test,
  }) {
    this._object_state = object_state;
    this._object_created = object_created;
    this._object_updated = object_updated;
    this._object_id = object_id;
    this._object_owner = object_owner;
    this._description = description;
    this._quantity = quantity;
    this._net_weight = net_weight;
    this._mass_unit = mass_unit;
    this._value_amount = value_amount;
    this._value_amount = value_currency;
    this._origin_country = origin_country;
    this._tariff_number = tariff_number;
    this._sku_code = sku_code;
    this._metadata = metadata;
    this._test = test;
  }

  CustomItem.fromMap(Map<String, dynamic> obj) {
    this._object_state = obj['object_state'];
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._description = obj['description'];
    this._quantity = obj['quantity'];
    this._net_weight = obj['net_weight'];
    this._mass_unit = obj['mass_unit'];
    this._value_amount = obj['value_amount'];
    this._value_amount = obj['value_currency'];
    this._origin_country = obj['origin_country'];
    this._tariff_number = obj['tariff_number'];
    this._sku_code = obj['sku_code'];
    this._metadata = obj['metadata'];
    this._test = obj['test'];
  }

  CustomItem.map(dynamic obj) {
    this._object_state = obj['object_state'];
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._description = obj['description'];
    this._quantity = obj['quantity'];
    this._net_weight = obj['net_weight'];
    this._mass_unit = obj['mass_unit'];
    this._value_amount = obj['value_amount'];
    this._value_currency = obj['value_currency'];
    this._origin_country = obj['origin_country'];
    this._tariff_number = obj['tariff_number'];
    this._sku_code = obj['sku_code'];
    this._metadata = obj['metadata'];
    this._test = obj['test'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._object_state != null) map['object_state'] = this._object_state;
    if (this._object_created != null)
      map['object_created'] = this._object_created;
    if (this._object_updated != null)
      map['object_updated'] = this._object_updated;
    if (this._object_id != null) map['object_id'] = this._object_id;
    if (this._object_owner != null) map['object_owner'] = this._object_owner;
    if (this._description != null) map['description'] = this._description;
    if (this._quantity != null) map['quantity'] = this._quantity;
    if (this._net_weight != null) map['net_weight'] = this._net_weight;
    if (this._mass_unit != null) map['mass_unit'] = this._mass_unit;
    if (this._value_amount != null) map['value_amount'] = this._value_amount;
    if (this._value_currency != null)
      map['value_currency'] = this._value_currency;
    if (this._origin_country != null)
      map['origin_country'] = this._origin_country;
    if (this._tariff_number != null) map['tariff_number'] = this._tariff_number;
    if (this._sku_code != null) map['sku_code'] = this._sku_code;
    if (this._metadata != null) map['metadata'] = this._metadata;
    if (this._test != null) map['test'] = this._test;
    return map;
  }
}

class CustomItemBody {
  String _description;
  String _quantity;
  String _net_weight;
  String _mass_unit;
  String _value_amount;
  String _value_currency;
  String _origin_country;
  String _tariff_number;
  String _sku_code;
  String _metadata;

  String get description => this._description ?? '';

  String get quantity => this._quantity ?? '';

  String get net_weight => this._net_weight ?? '';

  String get mass_unit => this._mass_unit ?? '';

  String get value_amount => this._value_amount ?? '';

  String get value_currency => this._value_currency ?? '';

  String get origin_country => this._origin_country ?? '';

  String get metadata => this._metadata ?? '';

  String get tariff_number => this._tariff_number ?? '';

  String get sku_code => this._sku_code;

  CustomItemBody(
      {String description,
      String quantity,
      String net_weight,
      String mass_unit,
      String value_amount,
      String value_currency,
      String origin_country,
      String tariff_number,
      String sku_code,
      String metadata}) {
    this._description = description;
    this._quantity = quantity;
    this._net_weight = net_weight;
    this._mass_unit = mass_unit;
    this._value_amount = value_amount;
    this._value_amount = value_currency;
    this._origin_country = origin_country;
    this._tariff_number = tariff_number;
    this._sku_code = sku_code;
    this._metadata = metadata;
  }

  CustomItemBody.fromMap(Map<String, dynamic> obj) {
    this._description = obj['description'];
    this._quantity = obj['quantity'];
    this._net_weight = obj['net_weight'];
    this._mass_unit = obj['mass_unit'];
    this._value_amount = obj['value_amount'];
    this._value_amount = obj['value_currency'];
    this._origin_country = obj['origin_country'];
    this._tariff_number = obj['tariff_number'];
    this._sku_code = obj['sku_code'];
    this._metadata = obj['metadata'];
  }

  CustomItemBody.map(dynamic obj) {
    this._description = obj['description'];
    this._quantity = obj['quantity'];
    this._net_weight = obj['net_weight'];
    this._mass_unit = obj['mass_unit'];
    this._value_amount = obj['value_amount'];
    this._value_currency = obj['value_currency'];
    this._origin_country = obj['origin_country'];
    this._tariff_number = obj['tariff_number'];
    this._sku_code = obj['sku_code'];
    this._metadata = obj['metadata'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._description != null) map['description'] = this._description;
    if (this._quantity != null) map['quantity'] = this._quantity;
    if (this._net_weight != null) map['net_weight'] = this._net_weight;
    if (this._mass_unit != null) map['mass_unit'] = this._mass_unit;
    if (this._value_amount != null) map['value_amount'] = this._value_amount;
    if (this._value_currency != null)
      map['value_currency'] = this._value_currency;
    if (this._origin_country != null)
      map['origin_country'] = this._origin_country;
    if (this._tariff_number != null) map['tariff_number'] = this._tariff_number;
    if (this._sku_code != null) map['sku_code'] = this._sku_code;
    if (this._metadata != null) map['metadata'] = this._metadata;

    return map;
  }
}
