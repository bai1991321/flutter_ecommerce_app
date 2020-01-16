import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/refunds/refund.dart';
import '../../utiles/utils.dart';

Future<Refund> fetchRefundRetrieve(String refund_id) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json',
    'Shippo-API-Version': 'Version 2018-02-08'
  };
  final response =
      await http.get(SHIPPO_URL + '/refunds/$refund_id', headers: header);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Refund.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
