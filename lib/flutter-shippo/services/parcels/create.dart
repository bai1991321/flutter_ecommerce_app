import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/parcels/parcel.dart';
import '../../utiles/utils.dart';

Future<Parcel> parcelCreate(ParcelBody body) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json'
  };
  final response = await http.post(SHIPPO_URL + '/parcels/',
      headers: header, body: json.encode(body.toMap()));

  if (response.statusCode >= 200 && response.statusCode < 300) {
    // If the call to the server was successful, parse the JSON
    return Parcel.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class ParcelBody {
  String _template;
  String _length;
  String _width;
  String _height;
  String _distance_unit;
  String _weight;
  String _mass_unit;
  String _metadata;
  String _extra;

  String get template => this._template ?? '';

  String get length => this._length ?? '';

  String get width => this._width ?? '';

  String get height => this._height ?? '';

  String get distance_unit => this._distance_unit ?? '';

  String get weight => this._weight ?? '';

  String get mass_unit => this._mass_unit ?? '';

  String get metadata => this._metadata ?? '';

  String get extra => this._extra ?? '';

  ParcelBody({
    String template,
    String length,
    String width,
    String height,
    String distance_unit,
    String weight,
    String mass_unit,
    String metadata,
    String extra,
  }) {
    this._template = template;
    this._length = length;
    this._width = width;
    this._height = height;
    this._distance_unit = distance_unit;
    this._weight = weight;
    this._mass_unit = mass_unit;
    this._metadata = metadata;
    this._extra = extra;
  }

  ParcelBody.formMap(Map<String, dynamic> obj) {
    this._template = obj['template'];
    this._length = obj['length'];
    this._width = obj['width'];
    this._height = obj['height'];
    this._distance_unit = obj['distance_unit'];
    this._weight = obj['weight'];
    this._mass_unit = obj['mass_unit'];
    this._metadata = obj['metadata'];
    this._extra = obj['extra'];
  }

  ParcelBody.map(dynamic obj) {
    this._template = obj['template'];
    this._length = obj['length'];
    this._width = obj['width'];
    this._height = obj['height'];
    this._distance_unit = obj['distance_unit'];
    this._weight = obj['weight'];
    this._mass_unit = obj['mass_unit'];
    this._metadata = obj['metadata'];
    this._extra = obj['extra'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._template != null) map['template'] = this._template;
    if (this._length != null) map['length'] = this._length;
    if (this._width != null) map['width'] = this._width;
    if (this._height != null) map['height'] = this._height;
    if (this.distance_unit != null) map['distance_unit'] = this._distance_unit;
    if (this._weight != null) map['weight'] = this._weight;
    if (this._mass_unit != null) map['mass_unit'] = this._mass_unit;
    if (this._metadata != null) map['metadata'] = this._metadata;
    if (this._extra != null) map['extra'] = this._extra;

    return map;
  }
}
