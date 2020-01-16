import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/rates/list.dart';
import '../../utiles/utils.dart';

Future<RateList> fetchRatesForShipment(
    String shipment_id, String currency) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN'
  };
  final response = await http.get(
      SHIPPO_URL + '/shipments/$shipment_id/rates/$currency',
      headers: header);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return RateList.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
