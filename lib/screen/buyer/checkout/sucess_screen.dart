import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utils/navigation_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SucessScreen extends StatefulWidget {
  final Widget child;

  SucessScreen({Key key, this.child}) : super(key: key);

  _SucessScreenState createState() => _SucessScreenState();
}

class _SucessScreenState extends State<SucessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Icon(
                MdiIcons.checkCircleOutline,
                color: Colors.green,
                size: 180,
              ),
            ),
            Center(
              child: Text(
                "Thank you!",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "Successful payment.",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            Center(
              child: Text(
                "Have a great day!",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.white,
              child: Container(
                height: 50,
                width: 200,
                child: Text("Go to Home"),
                alignment: Alignment.center,
              ),
              onPressed: () {
                NavigationRouter.switchToBuyer(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
