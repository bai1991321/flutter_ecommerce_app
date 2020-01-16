import 'package:flutter/material.dart';

enum Service { ACTIVE, COMPLETED, CANCELED }

class Strings {
  static const String active = 'Active';
  static const String completed = 'Completed';
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
  Page(service: Service.ACTIVE, text: Strings.active, color: Colors.green),
  Page(service: Service.COMPLETED, text: Strings.completed, color: Colors.blue),
  Page(service: Service.CANCELED, text: Strings.canceled, color: Colors.yellow),
];
