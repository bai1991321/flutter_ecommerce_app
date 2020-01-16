import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/addresses/address.dart';
import '../../models/parcels/parcel.dart';
import '../../models/shipment/extra.dart';
import '../../models/shipment/shipment.dart';
import '../../utiles/utils.dart';

Future<Shipment> shipmentCreate(ShipmentBody body) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json',
  };

  final response = await http.post(SHIPPO_URL + '/shipments/',
      headers: header, body: json.encode(body.toMap()));

  if (response.statusCode >= 200 && response.statusCode < 300) {
    // If the call to the server was successful, parse the JSON
    return Shipment.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class ShipmentBody {
  Address _address_from;
  Address _address_to;
  List<Parcel> _parcels;
  String _shipment_date;
  Address _address_return;
  String _custom_declaration;
  ShipmentExtra _extra;
  String _metadata;
  bool _async;

  Address get address_from => this._address_from;

  Address get address_to => this._address_to;

  List<Parcel> get parcels => this._parcels;

  String get shipment_date => this._shipment_date;

  Address get address_return => this._address_return;

  String get custom_declaration => this._custom_declaration;

  bool get asyn => this._async;

  String get metadata => this._metadata;

  ShipmentExtra get extra => this._extra;

  ShipmentBody({
    Address address_from,
    Address address_to,
    List<Parcel> parcels,
    String shipment_date,
    Address address_return,
    String custom_declaration,
    ShipmentExtra extra,
    String metadata,
    bool asyn,
  }) {
    this._address_from = address_from;
    this._address_to = address_to;
    this._parcels = parcels;
    this._shipment_date = shipment_date;
    this._address_return = address_return;
    this._custom_declaration = custom_declaration;
    this._async = asyn;
    this._metadata = metadata;
    this._extra = extra;
  }

  ShipmentBody.formMap(Map<String, dynamic> obj) {
    this._address_from = Address.map(obj['address_from']);
    this._address_to = Address.map(obj['address_to']);
    this._parcels = obj['parcels'].map((e) => Parcel.map(e)).toList();
    this._shipment_date = obj['shipment_date'];
    this._address_return = Address.map(obj['address_return']);
    this._custom_declaration = obj['custom_declaration'];
    this._async = obj['async'];
    this._metadata = obj['metadata'];
    this._extra = ShipmentExtra.map(obj['extra']);
  }

  ShipmentBody.map(dynamic obj) {
    this._address_from = Address.map(obj['address_from']);
    this._address_to = Address.map(obj['address_to']);
    this._parcels = obj['parcels'].map((e) => Parcel.map(e)).toList();
    this._shipment_date = obj['shipment_date'];
    this._address_return = Address.map(obj['address_return']);
    this._custom_declaration = obj['custom_declaration'];
    this._async = obj['async'];
    this._metadata = obj['metadata'];
    this._extra = ShipmentExtra.map(obj['extra']);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._address_from != null)
      map['address_from'] = this._address_from.toMap();
    if (this._address_to != null) map['address_to'] = this._address_to.toMap();
    if (this._parcels != null)
      map['parcels'] = this._parcels.map((f) => f.toMap()).toList();
    if (this._shipment_date != null) map['shipment_date'] = this._shipment_date;
    if (this._address_return != null)
      map['address_return'] = this._address_return.toMap();
    if (this._custom_declaration != null)
      map['custom_declaration'] = this._custom_declaration;
    if (this._async != null) map['async'] = this._async;
    if (this._metadata != null) map['metadata'] = this._metadata;
    if (this._extra != null) map['extra'] = this._extra.toMap();

    return map;
  }
}
