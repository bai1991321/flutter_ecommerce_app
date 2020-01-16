import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/addresses/address.dart';
import '../../models/addresses/create.dart';
import '../../utiles/utils.dart';

Future<Address> addressCreate(AddressCreateBody body) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json',
  };
  dynamic _json = body.toMap();
  final response = await http.post(SHIPPO_URL + '/addresses/',
      headers: header, body: json.encode(_json));

  if (response.statusCode >= 200 && response.statusCode < 300) {
    // If the call to the server was successful, parse the JSON
    return Address.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
