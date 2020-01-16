class Review {
  String _id;
  String _buyerID;
  String _productID;
  String _supplierID;
  String _starts;
  String _description;
  String _created_at;

  Review(this._id, this._buyerID, this._productID, this._supplierID,
      this._starts, this._description, this._created_at);

  Review.map(dynamic obj) {
    print(
        "===================================================================================================");
    print(obj.toString());
    print(
        "===================================================================================================");
    this._id = obj['id'];
    this._buyerID = obj['buyerID'];
    this._productID = obj['productID'];
    this._supplierID = obj['supplierID'];
    this._starts = obj['starts'];
    this._description = obj['description'];
    this._created_at = obj['created_at'];
    print(
        "====================================end============================================================");
  }

  String get id => _id;

  String get buyerID => _buyerID;

  String get productID => _productID;

  String get supplierID => _supplierID;

  String get starts => _starts;

  String get description => _description;

  String get created_at => _created_at;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    print(
        "===================================================================================================");
    print(map);
    print(
        "===================================================================================================");
    if (_id != null) {
      map['id'] = _id;
    }
    map['buyerID'] = _buyerID;
    map['productID'] = _productID;
    map['supplierID'] = _supplierID;
    map['starts'] = _starts;
    map['description'] = _description;
    map['created_at'] = _created_at;

    return map;
  }

  Review.fromMap(Map<String, dynamic> map) {
    print(
        "===================================================================================================");
    print(map);
    print(
        "===================================================================================================");
    this._id = map['id'];
    this._buyerID = map['buyerID'];
    this._productID = map['productID'];
    this._supplierID = map['supplierID'];
    this._starts = map['starts'];
    this._description = map['description'];
    this._created_at = map['created_at'];
  }
}
