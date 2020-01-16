import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> fetchUser() async {}

final fInstance = Firestore.instance;

final currencyList = ['USD', 'SGD'];
double defAmount = 5.0;

double min = 0.0;
double max = 100.0;

String usd = 'USD';
String sgd = 'SGD';

String refundID;
