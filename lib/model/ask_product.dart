class AskProduct {
  String _id;
  String _askId;
  String _buyerId;
  String _product_name;
  String _quantity;
  String _specifications;
  String _description;
  String _delivery_date;
  String _budget;

  AskProduct(
      this._id,
      this._askId,
      this._buyerId,
      this._product_name,
      this._quantity,
      this._specifications,
      this._description,
      this._delivery_date,
      this._budget);

  AskProduct.map(dynamic obj) {
    this._id = obj['id'];
    this._askId = obj['askId'];
    this._buyerId = obj['buyerId'];
    this._product_name = obj['product_name'];
    this._quantity = obj['quantity'];
    this._specifications = obj['specifications'];
    this._description = obj['description'];
    this._delivery_date = obj['delivery_date'];
    this._budget = obj['budget'];
  }

  String get id => _id ?? "";

  String get askId => _askId ?? "";

  String get buyerId => _buyerId ?? "";

  String get product_name => _product_name ?? "";

  String get quantity => _quantity ?? "";

  String get specifications => _specifications ?? "";

  String get description => _description ?? "";

  String get delivery_date => _delivery_date ?? "";

  String get budget => _budget ?? "";

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_askId != null) {
      map['id'] = _id;
    }
    map['askId'] = _askId;
    map['buyerId'] = _buyerId;
    map['product_name'] = _product_name;
    map['quantity'] = _quantity;
    map['specifications'] = _specifications;
    map['description'] = _description;
    map['delivery_date'] = _delivery_date;
    map['budget'] = _budget;

    return map;
  }

  AskProduct.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._askId = map['askId'];
    this._buyerId = map['buyerId'];
    this._product_name = map['product_name'];
    this._quantity = map['quantity'];
    this._specifications = map['specifications'];
    this._description = map['description'];
    this._delivery_date = map['delivery_date'];
    this._budget = map['budget'];
  }
}
