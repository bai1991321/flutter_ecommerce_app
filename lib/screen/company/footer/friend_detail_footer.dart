import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/company.dart';

import 'productShowcase.dart';

class FriendShowcase extends StatefulWidget {
  FriendShowcase(this._company);

  final Company _company;

  @override
  _FriendShowcaseState createState() => new _FriendShowcaseState();
}

class _FriendShowcaseState extends State<FriendShowcase>
    with TickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _tabs = [
      new Tab(text: 'Products'),
      // new Tab(text: 'Skills'),
      // new Tab(text: 'Articles'),
    ];
    _pages = [
      new ProductShowcase(),
      // new SkillsShowcase(),
      // new ArticlesShowcase(),
    ];
    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        children: <Widget>[
          new TabBar(
            controller: _controller,
            tabs: _tabs,
            indicatorColor: Colors.white,
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(300.0),
            child: new TabBarView(
              controller: _controller,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
