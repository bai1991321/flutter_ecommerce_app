import 'package:flutter/material.dart';

class NavigationRouter {
  static void switchToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, "/LoginScreen", (Route<dynamic> route) => false);
  }

  static void switchToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, "/HomeScreen", (Route<dynamic> route) => false);
  }

  static void switchToBuyer(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, "/BuyerScreen", (Route<dynamic> route) => false);
  }

  static void switchToSupplier(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, "/SupplierScreen", (Route<dynamic> route) => false);
  }
}
