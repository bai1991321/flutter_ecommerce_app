import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/shipment/list.dart';
import '../../utiles/utils.dart';

Future<ShipmentList> fetchShipmentList(
    {String date_great, String date_less}) async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json'
  };
  String url = SHIPPO_URL + '/shipments/';
  if (date_great != null) {
    url = url + '?object_created_gte=$date_great&';
  } else
    url = url + '?';
  if (date_less != null) {
    url = url + 'object_created_lte=$date_less';
  } else {
    if (url.contains('&'))
      url.replaceAll('&', '');
    else
      url.replaceAll('?', '');
  }
  final response = await http.get(url, headers: header);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return ShipmentList.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
