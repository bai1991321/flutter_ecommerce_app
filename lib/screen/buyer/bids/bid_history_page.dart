import 'package:flutter/material.dart';

import 'bid_canceled_fragment.dart';
import 'bid_created_fragment.dart';
import 'bid_rejected_fragment.dart';
import 'tab_page.dart';
// import 'bid_accepted_fragment.dart';

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
    return MaterialApp(
        title: _currentTab.text,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Bid History"),
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
                    case Service.CREATED:
                      return BidCreatedFragment();
                      break;
                    case Service.ACCEPTED:
                      // return BidAcceptedFragment();
                      break;
                    case Service.REJECTED:
                      return BidRejectedFragment();
                      break;
                    case Service.CANCELED:
                      return BidCanceledFragment();
                      break;
                  }
                }).toList())));
  }
}
