import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/tracking/tracking.dart';
import '../../utiles/utils.dart';

Future<Tracking> carrierAccountCreate(
    String carrier, String tracking_number, String metadata) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json'
  };
  dynamic body = {
    'carrier': carrier,
    'tracking_number': tracking_number,
    'metadata': metadata
  };
  final response =
      await http.post(SHIPPO_URL + '/tracks/', headers: header, body: body);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Tracking.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
