import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/customDeclaration/customDeclaration.dart';
import '../../utiles/utils.dart';

Future<CustomDeclaration> fetchCustomItemRetrieve(String declaration_id) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json'
  };
  final response = await http.get(SHIPPO_URL + '/customs/items/$declaration_id',
      headers: header);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return CustomDeclaration.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
