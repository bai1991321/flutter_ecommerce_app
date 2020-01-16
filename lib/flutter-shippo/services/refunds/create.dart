import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/refunds/refund.dart';
import '../../utiles/utils.dart';

Future<Refund> refundCreate(RefundBody body) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json',
    'Shippo-API-Version': 'Version 2018-02-08'
  };
  final response = await http.post(SHIPPO_URL + '/refunds/',
      headers: header, body: body.toMap());

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Refund.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
