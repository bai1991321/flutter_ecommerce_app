import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/rates/rate.dart';
import '../../utiles/utils.dart';

Future<Rate> fetchRateRetrieve(String rate_id) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN'
  };
  final response =
      await http.get(SHIPPO_URL + '/rates/$rate_id/', headers: header);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Rate.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
