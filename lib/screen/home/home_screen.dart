import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/screen/company/company_edit_page.dart';
import 'package:flutter_ecommerce/services/firestore_company_service.dart';
import 'package:flutter_ecommerce/utils/navigation_router.dart';
import 'package:flutter_ecommerce/utils/util.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  FirebaseFirestoreServiceCompany db = new FirebaseFirestoreServiceCompany();

  _initStatus() {
    // _getCompanyInfo();
    if (Util.type == "") {
      _getCompanyInfo();
    } else {
      Timer(
          Duration(seconds: 5),
          () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => CompanyEditPage())));
    }
  }

  _getCompanyInfo() {
    db.getCompanyByID(Util.uid).listen((data) {
      if (data.documents.isEmpty) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => CompanyEditPage()));
      } else {
        data.documents.forEach((f) {
          Company _company = Company.fromMap(f.data);
          Util.companyname = _company.companyName;
          Util.companyPic = _company.profile;
          Util.companyID = _company.id;
          Util.companyDescription = _company.description;
          Util.type = _company.type;
          setState(() {
            if (_company.type == 'buyer') {
              NavigationRouter.switchToBuyer(context);
            } else if (_company.type == 'supplier') {
              NavigationRouter.switchToSupplier(context);
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CompanyEditPage()));
            }
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initStatus();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: const Text(
              Util.appname,
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Center(
            child: CircularProgressIndicator(),
          )),
    );
  }
}
