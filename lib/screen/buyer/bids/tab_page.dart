import 'package:flutter/material.dart';

enum Service { CREATED, ACCEPTED, REJECTED, CANCELED }

class Strings {
  static const String created = 'Created';
  static const String accepted = 'Accepted';
  static const String rejected = 'Rejected';
  static const String canceled = 'Canceled';
}

class Page {
  Page({this.service, this.text, this.icon, this.color});

  final Service service;
  final String text;
  final String icon;
  final Color color;
}

// ignore: non_constant_identifier_names
final List<Page> PAGES = <Page>[
  Page(service: Service.CREATED, text: Strings.created, color: Colors.green),
  Page(service: Service.ACCEPTED, text: Strings.accepted, color: Colors.blue),
  Page(service: Service.REJECTED, text: Strings.rejected, color: Colors.yellow),
  Page(
      service: Service.CANCELED, text: Strings.canceled, color: Colors.blueGrey)
];
