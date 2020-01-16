class ShipmentExtra {
  String _signature_confirmation;
  String _authority_to_leave;
  String _saturday_delivery;
  String _bypass_address_validation;
  String _request_retail_rates;
  String _customer_branch;
  String _premium;
  String _preferred_delivery_timeframe;
  String _lasership_attrs;
  String _lasership_declared_value;
  String _container_type;
  Billing _billing;
  COD _COD;
  Alcohol _alcohol;
  Insurance _insurance;
  String _usps_sort_type;
  String _usps_entry_facility;
  String _dangerous_goods_code;
  String _is_return;
  String _reference_1;
  String _reference_2;

  ShipmentExtra(
      {String signature_confirmation,
      String authority_to_leave,
      String saturday_delivery,
      String bypass_address_validation,
      String request_retail_rates,
      String customer_branch,
      String premium,
      String preferred_delivery_timeframe,
      String lasership_attrs,
      String lasership_declared_value,
      String container_type,
      Billing billing,
      COD cod,
      Alcohol alcohol,
      Insurance insurance,
      String usps_sort_type,
      String usps_entry_facility,
      String dangerous_goods_code,
      String is_return,
      String reference_1,
      String reference_2}) {
    this._signature_confirmation = signature_confirmation;
    this._authority_to_leave = authority_to_leave;
    this._saturday_delivery = saturday_delivery;
    this._bypass_address_validation = bypass_address_validation;
    this._request_retail_rates = request_retail_rates;
    this._customer_branch = customer_branch;
    this._premium = premium;
    this._preferred_delivery_timeframe = preferred_delivery_timeframe;
    this._lasership_attrs = lasership_attrs;
    this._lasership_declared_value = lasership_declared_value;
    this._container_type = container_type;
    this._billing = billing;
    this._COD = cod;
    this._alcohol = alcohol;
    this._insurance = insurance;
    this._usps_sort_type = usps_sort_type;
    this._usps_entry_facility = usps_entry_facility;
    this._dangerous_goods_code = dangerous_goods_code;
    this._is_return = is_return;
    this._reference_1 = reference_1;
    this._reference_2 = reference_2;
  }

  String get signature_confirmation => this._signature_confirmation;

  String get authority_to_leave => this._authority_to_leave;

  String get saturday_delivery => this._saturday_delivery;

  String get bypass_address_validation => this._bypass_address_validation;

  String get request_retail_rates => this._request_retail_rates;

  String get customer_branch => this._customer_branch;

  String get premium => this._premium;

  String get preferred_delivery_timeframe => this._preferred_delivery_timeframe;

  String get lasership_attrs => this._lasership_attrs;

  String get lasership_declared_value => this._lasership_declared_value;

  String get container_type => this._container_type;

  Billing get billing => this._billing;

  COD get cod => this._COD;

  Alcohol get alcohol => this._alcohol;

  Insurance get insurance => this._insurance;

  String get usps_sort_type => this._usps_sort_type;

  String get usps_entry_facility => this._usps_entry_facility;

  String get dangerous_goods_code => this._dangerous_goods_code;

  String get is_return => this._is_return;

  String get reference_1 => this._reference_1;

  String get reference_2 => this._reference_2;

  ShipmentExtra.fromMap(Map<String, dynamic> obj) {
    this._signature_confirmation = obj['signature_confirmation'];
    this._authority_to_leave = obj['authority_to_leave'];
    this._saturday_delivery = obj['saturday_delivery'];
    this._bypass_address_validation = obj['bypass_address_validation'];
    this._request_retail_rates = obj['request_retail_rates'];
    this._customer_branch = obj['customer_branch'];
    this._premium = obj['premium'];
    this._preferred_delivery_timeframe = obj['preferred_delivery_timeframe'];
    this._lasership_attrs = obj['lasership_attrs'];
    this._lasership_declared_value = obj['lasership_declared_value'];
    this._container_type = obj['container_type'];
    this._billing = obj['billing'];
    this._COD = obj['COD'];
    this._alcohol = obj['alcohol'];
    this._insurance = obj['insurance'];
    this._usps_sort_type = obj['usps_sort_type'];
    this._usps_entry_facility = obj['usps_entry_facility'];
    this._dangerous_goods_code = obj['dangerous_goods_code'];
    this._is_return = obj['is_return'];
    this._reference_1 = obj['reference_1'];
    this._reference_2 = obj['reference_2'];
  }

  ShipmentExtra.map(dynamic obj) {
    this._signature_confirmation = obj['signature_confirmation'];
    this._authority_to_leave = obj['authority_to_leave'];
    this._saturday_delivery = obj['saturday_delivery'];
    this._bypass_address_validation = obj['bypass_address_validation'];
    this._request_retail_rates = obj['request_retail_rates'];
    this._customer_branch = obj['customer_branch'];
    this._premium = obj['premium'];
    this._preferred_delivery_timeframe = obj['preferred_delivery_timeframe'];
    this._lasership_attrs = obj['lasership_attrs'];
    this._lasership_declared_value = obj['lasership_declared_value'];
    this._container_type = obj['container_type'];
    this._billing = obj['billing'];
    this._COD = obj['COD'];
    this._alcohol = obj['alcohol'];
    this._insurance = obj['insurance'];
    this._usps_sort_type = obj['usps_sort_type'];
    this._usps_entry_facility = obj['usps_entry_facility'];
    this._dangerous_goods_code = obj['dangerous_goods_code'];
    this._is_return = obj['is_return'];
    this._reference_1 = obj['reference_1'];
    this._reference_2 = obj['reference_2'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._signature_confirmation != null)
      map['signature_confirmation'] = this._signature_confirmation;
    if (this._authority_to_leave != null)
      map['authority_to_leave'] = this._authority_to_leave;
    if (this._saturday_delivery != null)
      map['saturday_delivery'] = this._saturday_delivery;
    if (this._bypass_address_validation != null)
      map['bypass_address_validation'] = this._bypass_address_validation;
    if (this._request_retail_rates != null)
      map['request_retail_rates'] = this._request_retail_rates;
    if (this._customer_branch != null)
      map['customer_branch'] = this._customer_branch;
    if (this._premium != null) map['premium'] = this._premium;
    if (this._preferred_delivery_timeframe != null)
      map['preferred_delivery_timeframe'] = this._preferred_delivery_timeframe;
    if (this._lasership_attrs != null)
      map['lasership_attrs'] = this._lasership_attrs;
    if (this._lasership_declared_value != null)
      map['lasership_declared_value'] = this._lasership_declared_value;
    if (this._container_type != null)
      map['container_type'] = this._container_type;
    if (this._billing != null) map['billing'] = this._billing;
    if (this._COD != null) map['COD'] = this._COD;
    if (this._alcohol != null) map['alcohol'] = this._alcohol;
    if (this._insurance != null) map['insurance'] = this._insurance;
    if (this._usps_sort_type != null)
      map['usps_sort_type'] = this._usps_sort_type;
    if (this._usps_entry_facility != null)
      map['usps_entry_facility'] = this._usps_entry_facility;
    if (this._dangerous_goods_code != null)
      map['dangerous_goods_code'] = this._dangerous_goods_code;
    if (this._is_return != null) map['is_return'] = this._is_return;
    if (this._reference_1 != null) map['reference_1'] = this._reference_1;
    if (this._reference_2 != null) map['reference_2'] = this._reference_2;
    return map;
  }
}

class Billing {
  String _type;
  String _account;
  String _zip;
  String _country;
  String _participation_code;

  Billing(
      {String type,
      String account,
      String zip,
      String country,
      String participation_code}) {
    this._type = type;
    this._account = account;
    this._zip = zip;
    this._country = country;
    this._participation_code = participation_code;
  }

  String get type => this._type;

  String get account => this._account;

  String get zip => this._zip;

  String get country => this._country;

  String get participation_code => this._participation_code;

  Billing.fromMap(Map<String, dynamic> obj) {
    this._type = obj['type'];
    this._account = obj['account'];
    this._zip = obj['zip'];
    this._country = obj['country'];
    this._participation_code = obj['participation_code'];
  }

  Billing.map(dynamic obj) {
    this._type = obj['type'];
    this._account = obj['account'];
    this._zip = obj['zip'];
    this._country = obj['country'];
    this._participation_code = obj['participation_code'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._type != null) map['type'] = this._type;
    if (this._account != null) map['account'] = this._account;
    if (this._zip != null) map['zip'] = this._zip;
    if (this._country != null) map['country'] = this._country;
    if (this._participation_code != null)
      map['participation_code'] = this._participation_code;

    return map;
  }
}

class COD {
  String _amount;
  String _currency;
  String _payment_method;

  COD({String amount, String currency, String payment_method}) {
    this._amount = amount;
    this._currency = currency;
    this._payment_method = payment_method;
  }

  String get amount => this._amount;

  String get currency => this._currency;

  String get payment_method => this._payment_method;

  COD.fromMap(Map<String, dynamic> obj) {
    this._amount = obj['amount'];
    this._currency = obj['currency'];
    this._payment_method = obj['payment_method'];
  }

  COD.map(dynamic obj) {
    this._amount = obj['amount'];
    this._currency = obj['currency'];
    this._payment_method = obj['payment_method'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._amount != null) map['amount'] = this._amount;
    if (this._currency != null) map['currency'] = this._currency;
    if (this._payment_method != null)
      map['payment_method'] = this._payment_method;
    return map;
  }
}

class Alcohol {
  String _contains_alcohol;
  String _recipient_type;

  Alcohol({String contains_alcohol, String recipient_type}) {
    this._contains_alcohol = contains_alcohol;
    this._recipient_type = recipient_type;
  }

  String get contains_alcohol => this._contains_alcohol;

  String get recipient_type => this._recipient_type;

  Alcohol.fromMap(Map<String, dynamic> obj) {
    this._contains_alcohol = obj['contains_alcohol'];
    this._recipient_type = obj['recipient_type'];
  }

  Alcohol.map(dynamic obj) {
    this._contains_alcohol = obj['contains_alcohol'];
    this._recipient_type = obj['recipient_type'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._contains_alcohol != null)
      map['contains_alcohol'] = this._contains_alcohol;
    if (this._recipient_type != null)
      map['recipient_type'] = this._recipient_type;

    return map;
  }
}

class DryIce {
  String _contains_dry_ice;
  String _weight;

  Alcohol({String contains_dry_ice, String weight}) {
    this._contains_dry_ice = contains_dry_ice;
    this._weight = weight;
  }

  String get contains_dry_ice => this._contains_dry_ice;

  String get weight => this._weight;

  DryIce.fromMap(Map<String, dynamic> obj) {
    this._contains_dry_ice = obj['contains_dry_ice'];
    this._weight = obj['weight'];
  }

  DryIce.map(dynamic obj) {
    this._contains_dry_ice = obj['contains_dry_ice'];
    this._weight = obj['weight'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._contains_dry_ice != null)
      map['contains_dry_ice'] = this._contains_dry_ice;
    if (this._weight != null) map['weight'] = this._weight;

    return map;
  }
}

class Insurance {
  String _amount;
  String _currency;
  String _content;
  String _provider;

  Insurance({
    String amount,
    String currency,
    String content,
    String provider,
  }) {
    this._amount = amount;
    this._currency = currency;
    this._content = content;
    this._provider = provider;
  }

  String get amount => this._amount;

  String get currency => this._currency;

  String get content => this._content;

  String get provider => this._provider;

  Insurance.fromMap(Map<String, dynamic> obj) {
    this._amount = obj['amount'];
    this._currency = obj['currency'];
    this._content = obj['content'];
    this._provider = obj['provider'];
  }

  Insurance.map(dynamic obj) {
    this._amount = obj['amount'];
    this._currency = obj['currency'];
    this._content = obj['content'];
    this._provider = obj['provider'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._amount != null) map['amount'] = this._amount;
    if (this._currency != null) map['currency'] = this._currency;
    if (this._content != null) map['content'] = this._content;
    if (this._provider != null) map['provider'] = this._provider;

    return map;
  }
}
