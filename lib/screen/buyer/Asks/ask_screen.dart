import 'package:flutter/material.dart';

import 'ask_active_fragment.dart';
import 'ask_canceled_fragment.dart';
import 'ask_completed_fragment.dart';
import 'ask_tab.dart';

class AskScreen extends StatefulWidget {
  @override
  _AskScreenState createState() => _AskScreenState();
}

class _AskScreenState extends State<AskScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  Page _currentTab;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: PAGES.length);
    _controller.addListener(() {
      setState(() {
        _currentTab = PAGES[_controller.index];
      });
    });
    _currentTab = PAGES[_controller.index];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _currentTab.text,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Asks"),
              centerTitle: true,
              backgroundColor: Colors.amber,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                alignment: Alignment.centerLeft,
                tooltip: 'Cancel',
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: TabBar(
                controller: _controller,
                isScrollable: false,
                tabs: PAGES.map((Page page) {
                  return Tab(
                    text: page.text,
                  );
                }).toList(),
              ),
            ),
            body: TabBarView(
                controller: _controller,
                children: PAGES.map((Page page) {
                  switch (page.service) {
                    case Service.ACTIVE:
                      return AskActiveFragment();
                      break;
                    case Service.COMPLETED:
                      return AskCompletedFragment();
                      break;
                    case Service.CANCELED:
                      return AskCanceledFragment();
                      break;
                  }
                }).toList())));
  }
}
