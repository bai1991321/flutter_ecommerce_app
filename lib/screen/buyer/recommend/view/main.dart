import 'package:flutter/material.dart';

import 'screens/home/index.dart';

class RecommendViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData(
          primarySwatch: Colors.amber,
          canvasColor: Colors.amber[800],
        ),
        child: HomePage(),
      ),
    );
  }
}
