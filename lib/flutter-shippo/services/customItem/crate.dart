import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/customItem/customItem.dart';
import '../../utiles/utils.dart';

Future<CustomItem> customItemCreate(CustomItemBody body) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json'
  };
  final response = await http.post(SHIPPO_URL + '/customs/items/',
      headers: header, body: body.toMap());

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return CustomItem.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
