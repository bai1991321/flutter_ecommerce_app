class Category {
  String _id;
  String _name;
  String _icon;

  Category(this._id, this._name, this._icon);

  @override
  String toString() {
    return 'Category{name: $_name, icon: $_icon}';
  }

  Category.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._icon = obj['image'];
  }

  String get id => this._id ?? '';
  set id(String str) => this._id = str;

  String get name => this._name ?? '';

  String get icon => this._icon ?? '';

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = this._name;
    map['image'] = this._icon;
    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._icon = map['image'];
  }
}
