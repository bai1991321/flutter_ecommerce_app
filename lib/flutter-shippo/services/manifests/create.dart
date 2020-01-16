import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/manifests/manifest.dart';
import '../../utiles/utils.dart';

Future<Manifest> manifestCreate(ManifestBody body) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json'
  };
  final response = await http.post(SHIPPO_URL + '/manifests/',
      headers: header, body: body.toMap());

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Manifest.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
