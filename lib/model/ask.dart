class Ask {
  String _id;
  String _authId;
  String _ask_title;
  String _description;
  String _status;
  String _created_date;
  String _updated_date;

  Ask(this._id, this._authId, this._ask_title, this._description, this._status,
      this._created_date, this._updated_date);

  Ask.map(dynamic obj) {
    this._id = obj['id'];
    this._authId = obj['authid'];
    this._ask_title = obj['ask_title'];
    this._description = obj['description'];
    this._status = obj['status'];
    this._created_date = obj['c reated_date'];
    this._updated_date = obj['updated_date'];
  }

  String get id => _id ?? "";

  String get authid => _authId ?? "";

  String get ask_title => _ask_title ?? "";

  String get description => _description ?? "";

  String get status => _status ?? "";

  String get created_date => _created_date ?? "";

  String get updated_date => _updated_date ?? "";

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_authId != null) {
      map['id'] = _id;
    }
    map['authid'] = _authId;
    map["ask_title"] = _ask_title;
    map['description'] = _description;
    map['status'] = _status;
    map['created_date'] = _created_date;
    map['updated_date'] = _updated_date;

    return map;
  }

  Ask.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._authId = map['authid'];
    this._status = map['status'];
    this._ask_title = map['ask_title'];
    this._description = map['description'];
    this._created_date = map['created_date'];
    this._updated_date = map['updated_date'];
  }

  setUpdateDate(String datetime) {
    _updated_date = datetime;
  }

  setStatus(String status) {
    _status = status;
  }

  setTitle(String title) {
    _ask_title = title;
  }

  setDescription(String description) {
    _description = description;
  }
}
