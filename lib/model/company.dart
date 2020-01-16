class Company {
  String _authId;
  String _companyName;
  String _profile;
  String _type;
  String _description;

  Company(this._authId, this._companyName, this._description, this._profile,
      this._type);

  Company.map(dynamic obj) {
    this._authId = obj['authid'];
    this._companyName = obj['companyName'];
    this._description = obj['description'];
    this._profile = obj['profile'];
    this._type = obj['type'];
  }

  String get id => _authId ?? "";

  String get description => _description ?? "";

  String get companyName => _companyName ?? "";

  String get profile => _profile ?? "";

  String get type => _type ?? "";

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_authId != null) {
      map['authid'] = _authId;
    }
    map['companyName'] = _companyName;
    map['description'] = _description;
    map['profile'] = _profile;
    map['type'] = _type;

    return map;
  }

  Company.fromMap(Map<String, dynamic> map) {
    this._authId = map['authid'];
    this._companyName = map['companyName'];
    this._description = map['description'];
    this._profile = map['profile'];
    this._type = map['type'];
  }
}
