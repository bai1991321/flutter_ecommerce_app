class Bid {
  String _id;
  String _authId;
  String _askID;
  String _askProductID;
  String _buyerID;
  String _bid_title;
  String _amount;
  String _quantity;
  String _imageURL;
  String _status;
  String _created_date;
  String _updated_date;
  String _supportProductId;

  Bid(
      this._id,
      this._authId,
      this._askID,
      this._askProductID,
      this._buyerID,
      this._bid_title,
      this._amount,
      this._quantity,
      this._imageURL,
      this._status,
      this._created_date,
      this._updated_date,
      this._supportProductId);

  Bid.map(dynamic obj) {
    this._id = obj['id'];
    this._authId = obj['authid'];
    this._askID = obj['askID'];
    this._askProductID = obj['askProductID'];
    this._buyerID = obj['buyerID'];
    this._bid_title = obj['bid_title'];
    this._amount = obj['amount'];
    this._quantity = obj['quantity'];
    this._imageURL = obj['imageURL'];
    this._status = obj['status'];
    this._created_date = obj['created_date'];
    this._updated_date = obj['updated_date'];
    this._supportProductId = obj['supportProductId'];
  }

  String get id => _id ?? "";

  String get authid => _authId ?? "";

  String get askID => _askID ?? "";

  String get askProductID => _askProductID ?? "";

  String get buyerID => _buyerID ?? "";

  String get bid_title => _bid_title ?? "";

  String get amount => _amount ?? "";

  String get quantity => _quantity ?? "";

  String get imageURL => _imageURL ?? "";

  String get status => _status ?? "";

  String get created_date => _created_date ?? "";

  String get updated_date => _updated_date ?? "";

  String get supportProductId => _supportProductId ?? '';

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_authId != null) {
      map['id'] = _id;
    }
    map['authid'] = _authId;
    map['askID'] = _askID;
    map['askProductID'] = _askProductID;
    map['buyerID'] = _buyerID;
    map['bid_title'] = _bid_title;
    map['amount'] = _amount;
    map['quantity'] = _quantity;
    map['imageURL'] = _imageURL;
    map['status'] = _status;
    map['created_date'] = _created_date;
    map['updated_date'] = _updated_date;
    map['supportProductId'] = _supportProductId;

    return map;
  }

  Bid.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._authId = map['authid'];
    this._askID = map['askID'];
    this._buyerID = map['buyerID'];
    this._askProductID = map['askProductID'];
    this._bid_title = map['bid_title'];
    this._amount = map['amount'];
    this._quantity = map['quantity'];
    this._imageURL = map['imageURL'];
    this._status = map['status'];
    this._created_date = map['created_date'];
    this._updated_date = map['updated_date'];
    this._supportProductId = map['supportProductId'];
  }

  setUpdateDate(String datetime) {
    _updated_date = datetime;
  }

  setStatus(String status) {
    _status = status;
  }

  setBid_title(String bid_title) {
    _bid_title = bid_title;
  }

  setAmount(String amount) {
    _amount = amount;
  }

  setQuantity(String quantity) {
    _quantity = quantity;
  }

  setImageURL(String url) {
    _imageURL = url;
  }
}
