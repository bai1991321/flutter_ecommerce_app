class Follow {
  String _id;
  String _buyerID;
  String _supplierID;
  String _created_at;

  Follow(this._id, this._buyerID, this._supplierID, this._created_at);

  Follow.map(dynamic obj) {
    print(
        "===================================================================================================");
    print(obj.toString());
    print(
        "===================================================================================================");
    this._id = obj['id'];
    this._buyerID = obj['buyerID'];
    this._supplierID = obj['supplierID'];
    this._created_at = obj['created_at'];
    print(
        "====================================end============================================================");
  }

  String get id => _id;

  String get buyerID => _buyerID;

  String get supplierID => _supplierID;

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
    map['supplierID'] = _supplierID;
    map['created_at'] = _created_at;

    return map;
  }

  Follow.fromMap(Map<String, dynamic> map) {
    print(
        "===================================================================================================");
    print(map);
    print(
        "===================================================================================================");
    this._id = map['id'];
    this._buyerID = map['buyerID'];
    this._supplierID = map['supplierID'];
    this._created_at = map['created_at'];
  }
}
