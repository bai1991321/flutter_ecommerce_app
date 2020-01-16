import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/transactions/list.dart';
import '../../utiles/utils.dart';

Future<TransactionList> fetchTransactionsList() async {
  Map<String, String> header = {
    'Authorization': 'ShippoToken $SHIPPO_AUTH_TOKEN',
    'Content-Type': 'application/json'
  };
  final response =
      await http.get(SHIPPO_URL + '/transactions/', headers: header);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return TransactionList.fromMap(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
