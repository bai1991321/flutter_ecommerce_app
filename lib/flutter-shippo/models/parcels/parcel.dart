class Parcel {
  String _object_state;
  String _object_created;
  String _object_updated;
  String _object_id;
  String _object_owner;
  String _template;
  String _length;
  String _width;
  String _height;
  String _distance_unit;
  String _weight;
  String _mass_unit;
  String _metadata;
  String _extra;
  bool _test;

  String get object_state => this._object_state ?? '';

  String get object_created => this._object_created ?? '';

  String get object_updated => this._object_updated ?? '';

  String get object_id => this._object_id ?? '';

  String get object_owner => this._object_owner ?? '';

  String get template => this._template ?? '';

  String get length => this._length ?? '';

  String get width => this._width ?? '';

  String get height => this._height ?? '';

  String get distance_unit => this._distance_unit ?? '';

  String get weight => this._weight ?? '';

  String get mass_unit => this._mass_unit ?? '';

  String get metadata => this._metadata ?? '';

  String get extra => this._extra ?? '';

  bool get test => this._test;

  Parcel(
      {String object_state,
      String object_created,
      String object_updated,
      String object_id,
      String object_owner,
      String template,
      String length,
      String width,
      String height,
      String distance_unit,
      String weight,
      String mass_unit,
      String metadata,
      String extra,
      bool test}) {
    this._object_state = object_state;
    this._object_created = object_created;
    this._object_updated = object_updated;
    this._object_id = object_id;
    this._object_owner = object_owner;
    this._template = template;
    this._length = length;
    this._width = width;
    this._height = height;
    this._distance_unit = distance_unit;
    this._weight = weight;
    this._mass_unit = mass_unit;
    this._metadata = metadata;
    this._extra = extra;
    this._test = test;
  }

  Parcel.fromMap(Map<String, dynamic> obj) {
    this._object_state = obj['object_state'];
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._template = obj['template'];
    this._length = obj['length'];
    this._width = obj['width'];
    this._height = obj['height'];
    this._distance_unit = obj['distance_unit'];
    this._weight = obj['weight'];
    this._mass_unit = obj['mass_unit'];
    this._metadata = obj['metadata'];
    // this._extra = obj['extra'].map();
    this._test = obj['test'];
  }

  Parcel.map(dynamic obj) {
    this._object_state = obj['object_state'];
    this._object_created = obj['object_created'];
    this._object_updated = obj['object_updated'];
    this._object_id = obj['object_id'];
    this._object_owner = obj['object_owner'];
    this._template = obj['template'];
    this._length = obj['length'];
    this._width = obj['width'];
    this._height = obj['height'];
    this._distance_unit = obj['distance_unit'];
    this._weight = obj['weight'];
    this._mass_unit = obj['mass_unit'];
    this._metadata = obj['metadata'];
    // this._extra = obj['extra'];
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
    if (this._template != null) map['template'] = this._template;
    if (this._length != null) map['length'] = this._length;
    if (this._width != null) map['width'] = this._width;
    if (this._height != null) map['height'] = this._height;
    if (this._distance_unit != null) map['distance_unit'] = this._distance_unit;
    if (this._weight != null) map['weight'] = this._weight;
    if (this._mass_unit != null) map['mass_unit'] = this._mass_unit;
    if (this._metadata != null) map['metadata'] = this._metadata;
    if (this._extra != null) map['extra'] = this._metadata;
    if (this._test != null) map['test'] = this._test;
    return map;
  }
}
