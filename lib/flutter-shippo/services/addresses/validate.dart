import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/addresses/address.dart';
import '../../utiles/utils.dart';

Future<Address> fetchAddressValidate(String address_id) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json'
  };
  final response = await http.get(
      SHIPPO_URL + '/addresses/' + address_id + '/validate/',
      headers: header);

  if (response.statusCode >= 200 && response.statusCode < 300) {
    // If the call to the server was successful, parse the JSON
    return Address.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
