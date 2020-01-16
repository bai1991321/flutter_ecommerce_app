import 'package:flutter/material.dart';

import 'bid_active_fragment.dart';
import 'bid_canceled_fragment.dart';
import 'bid_completeted_fragment.dart';
import 'tab_page.dart';

class BidHistoryPage extends StatefulWidget {
  @override
  _BidHistoryPageState createState() => _BidHistoryPageState();
}

class _BidHistoryPageState extends State<BidHistoryPage>
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
    ThemeData themeData = ThemeData(
        primarySwatch: _currentTab.color,
        primaryColor: _currentTab.color,
        accentColor: _currentTab.color,
        brightness: Brightness.dark);

    return MaterialApp(
        title: _currentTab.text,
        //      theme: themeData,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Bids"),
              centerTitle: true,
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
                indicatorColor: themeData.textTheme.title.color,
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
                      return BidActiveFragment();
                      break;
                    case Service.COMPLETED:
                      return BidCompletededFragment();
                      break;
                    case Service.CANCELED:
                      return BidCanceledFragment();
                      break;
                  }
                }).toList())));
  }
}
