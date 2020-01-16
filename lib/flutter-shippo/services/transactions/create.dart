import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/shipment/shipment.dart';
import '../../models/transactions/transaction.dart';
import '../../utiles/utils.dart';

Future<Transactions> transactionRateCreate(TransationRateBody body) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json'
  };
  final response = await http.post(SHIPPO_URL + '/transactions/',
      headers: header, body: json.encode(body.toMap()));

  if (response.statusCode >= 200 && response.statusCode < 300) {
    // If the call to the server was successful, parse the JSON
    return Transactions.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<Transactions> transactionInstantCreate(
    TransationInstantBody body) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN'
  };
  final response = await http.post(SHIPPO_URL + '/transactions/',
      headers: header, body: json.encode(body.toMap()));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Transactions.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class TransationRateBody {
  String _rate;
  String _metadata;
  String _label_file_type;
  bool _async;

  TransationRateBody({
    String rate,
    String metadata,
    String label_file_type,
    bool asyn,
  }) {
    this._rate = rate;
    this._metadata = metadata;
    this._label_file_type = label_file_type;
    this._async = asyn;
  }

  String get rate => this._rate;

  String get metadata => this._metadata;

  String get label_file_type => this._label_file_type;

  bool get asyn => this._async;

  TransationRateBody.fromMap(Map<String, dynamic> obj) {
    this._rate = obj['rate'];
    this._metadata = obj['metadata'];
    this._label_file_type = obj['label_file_type'];
    this._async = obj['async'];
  }

  TransationRateBody.map(dynamic obj) {
    this._rate = obj['rate'];
    this._metadata = obj['metadata'];
    this._label_file_type = obj['label_file_type'];
    this._async = obj['async'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._rate != null) map['rate'] = this._rate;
    if (this._metadata != null) map['metadata'] = this._metadata;
    if (this._label_file_type != null)
      map['label_file_type'] = this._label_file_type;
    if (this._async != null) map['async'] = this._async;

    return map;
  }
}

class TransationInstantBody {
  Shipment _shipment;
  String _carrier_account;
  String _servicelevel_token;
  String _metadata;
  String _label_file_type;

  TransationInstantBody({
    Shipment shipment,
    String carrier_account,
    String servicelevel_token,
    String metadata,
    String label_file_type,
  }) {
    this._shipment = shipment;
    this._carrier_account = carrier_account;
    this._servicelevel_token = servicelevel_token;
    this._metadata = metadata;
    this._label_file_type = label_file_type;
  }

  Shipment get shipment => this._shipment;

  String get carrier_account => this._carrier_account;

  String get servicelevel_token => this._servicelevel_token;

  String get metadata => this._metadata;

  String get label_file_type => this._label_file_type;

  TransationInstantBody.fromMap(Map<String, dynamic> obj) {
    this._shipment = obj['shipment'];
    this._carrier_account = obj['carrier_account'];
    this._servicelevel_token = obj['servicelevel_token'];
    this._metadata = obj['metadata'];
    this._label_file_type = obj['label_file_type'];
  }

  TransationInstantBody.map(dynamic obj) {
    this._shipment = obj['shipment'];
    this._carrier_account = obj['carrier_account'];
    this._servicelevel_token = obj['servicelevel_token'];
    this._metadata = obj['metadata'];
    this._label_file_type = obj['label_file_type'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (this._shipment != null) map['shipment'] = this._shipment;
    if (this._carrier_account != null)
      map['carrier_account'] = this._carrier_account;
    if (this._servicelevel_token != null)
      map['servicelevel_token'] = this._servicelevel_token;
    if (this._metadata != null) map['metadata'] = this._metadata;
    if (this._label_file_type != null)
      map['label_file_type'] = this._label_file_type;

    return map;
  }
}
