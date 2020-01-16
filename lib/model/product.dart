import 'dart:math';

class Product {
  String _id;
  String _supplier;
  String _itemname;
  String _preprice;
  String _price;
  String _badge;
  String _rating;
  String _description;
  String _category;
  List<String> _imageUrl;
  String _created_at;
  String _distance_unit;
  String _length;
  String _width;
  String _height;
  String _mass_unit;
  String _weight;
  String _amount;
  String _subcategory;

  Product(
      this._id,
      this._supplier,
      this._itemname,
      this._preprice,
      this._price,
      this._badge,
      this._rating,
      this._description,
      this._category,
      this._subcategory,
      this._amount,
      this._imageUrl,
      this._created_at,
      this._distance_unit,
      this._length,
      this._width,
      this._height,
      this._mass_unit,
      this._weight);

  Product.map(dynamic obj) {
    print(
        "===================================================================================================");
    print(obj.toString());
    print(
        "===================================================================================================");
    this._id = obj['id'];
    this._supplier = obj['supplier'];
    this._itemname = obj['itemname'];
    this._preprice = obj['preprice'];
    this._price = obj['price'];
    this._badge = obj['badge'];
    this._rating = obj['rating'];
    this._description = obj['description'];
    this._category = obj['category'];
    this._subcategory = obj['subCategory'];
    this._imageUrl = obj['imageUrl'].map().toList();
    this._created_at = obj['created_at'];
    this._distance_unit = obj['distance_unit'];
    this._length = obj['length'];
    this._width = obj['width'];
    this._height = obj['height'];
    this._mass_unit = obj['mass_unit'];
    this._weight = obj['weight'];
    this._amount =obj['amount'];
    print(
        "====================================end============================================================");
  }

  String get id => _id;

  String get supplier => _supplier;

  String get itemname => _itemname;

  String get preprice => _preprice;

  String get price => _price;

  String get badge => _badge;

  String get rating => "0.0"; //_rating;
  String get description => _description;

  String get category => _category;
  String get subcategory => _subcategory;

  List<String> get imageUrl => _imageUrl;

  String get created_at => _created_at;

  String get distance_unit => _distance_unit ?? "";

  String get length => _length ?? "";

  String get width => _width ?? "";

  String get height => _height ?? "";

  String get mass_unit => _mass_unit ?? "";

  String get weight => _weight ?? "";

  String get amount => _amount ?? "";

  set distance_unit(String value) {
    this._distance_unit = value;
  }

  set length(String value) {
    this._length = value;
  }

  set category(String value){
    this._category =value;
  }

  set description(String value){
    this._description =value;
  }

  set imageUrl(List<String> value){
    this._imageUrl =value;
  }

  set itemname(String value){
    this._itemname =value;
  }

  set preprice(String value){
    this._preprice = value;
  }
  
  set price(String value){
    this._price =value;
  }

  set width(String value) {
    this._width = value;
  }

  set height(String value) {
    this._height = value;
  }

  set mass_unit(String value) {
    this._mass_unit = value;
  }

  set weight(String value) {
    this._weight = value;
  }

  set subcategory(String value) {
    this._subcategory = value;
  }

  set amount(String value) {
    this._amount = value;
  }

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
    map['supplier'] = _supplier;
    map['itemname'] = _itemname;
    map['preprice'] = _preprice;
    map['price'] = _price;
    map['badge'] = _badge;
    map['description'] = _description;
    map['category'] = _category;
    map['imageUrl'] = imageUrl.map((f) => f);
    map['rating'] = _rating;
    map['created_at'] = _created_at;
    map['distance_unit'] = _distance_unit;
    map['length'] = _length;
    map['width'] = _width;
    map['height'] = _height;
    map['mass_unit'] = _mass_unit;
    map['weight'] = _weight;
    map['subCategory'] = _subcategory;
    map['amount'] =_amount;

    return map;
  }

  Product.fromMap(Map<String, dynamic> map) {
    print(
        "===================================================================================================");
    print(map);
    print(
        "===================================================================================================");
    this._id = map['id'];
    this._supplier = map['supplier'];
    this._itemname = map['itemname'];
    this._preprice = map['preprice'];
    this._price = map['price'];
    this._badge = map['badge'];
    this._description = map['description'];
    this._category = map['category'];
    this._imageUrl = (map['imageUrl']).map().toList();
    this._rating = (Random().nextInt(10) / 2).toString(); //map['rating'];
    this._created_at = map['created_at'];
    this._distance_unit = map['distance_unit'];
    this._length = map['length'];
    this._width = map['width'];
    this._height = map['height'];
    this._mass_unit = map['mass_unit'];
    this._weight = map['weight'];
    this._subcategory =map['subCategory'];
    this._amount =map['amount'];
  }
}
