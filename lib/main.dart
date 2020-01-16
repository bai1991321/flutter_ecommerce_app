import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screen/login/login_screen.dart';
import 'package:flutter_ecommerce/screen/splash_screen.dart';
import 'package:flutter_ecommerce/screen/buyer/dashboard/Company_dashboard_screen.dart';
import 'package:flutter_ecommerce/screen/supplier/supplier_dashboard_screen.dart';
import 'screen/company/company_screen.dart';
import 'screen/home/home_screen.dart';

var routes = <String, WidgetBuilder>{
  "/LoginScreen": (BuildContext context) => LoginScreen(),
  "/HomeScreen": (BuildContext context) => HomeScreen(),
  "/BuyerScreen": (BuildContext context) => CompanyDashboardScreen(),
  "/SupplierScreen": (BuildContext context) => SupplierDashboardScreen(),
};

void main() => runApp(new MaterialApp(
    theme: ThemeData(
        primaryColor: Colors.redAccent,
        primarySwatch: Colors.amber,
        primaryColorDark: Colors.amber[900]),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: routes));
