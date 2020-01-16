import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/screen/company/company_screen.dart';
import 'package:flutter_ecommerce/services/firestore_company_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CompanyListPage extends StatefulWidget {
  _CompanyListPageState createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage>
    with TickerProviderStateMixin {
  List<Company> data = [];
  int indexPage = 0;
  RefreshController _controller;
  FirebaseFirestoreServiceCompany db = FirebaseFirestoreServiceCompany();

  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  void _fetch() {
    db
        .getCompanyList(offset: indexPage, limit: 10)
        .listen((onData) => onData.documents.forEach((f) {
              Company company = Company.map(f.data);

              setState(() {
                data.add(company);
                _controller.sendBack(false, RefreshStatus.idle);
                indexPage++;
              });
            }));
  }

  void _onRefresh(bool up) {
    if (up)
      new Future.delayed(const Duration(milliseconds: 1000)).then((val) {
        _controller.sendBack(true, RefreshStatus.completed);
//                refresher.sendStatus(RefreshStatus.completed);
      });
    else {
      print("sd");
      new Future.delayed(const Duration(milliseconds: 1000)).then((val) {
        _fetch();
      });
    }
  }

  Widget _headerCreate(BuildContext context, int mode) {
    return new ClassicIndicator(mode: mode);
  }

  Widget _footerCreate(BuildContext context, int mode) {
    return new ClassicIndicator(
      mode: mode,
      refreshingText: 'loading...',
      idleIcon: const Icon(Icons.arrow_upward),
      idleText: 'Loadmore...',
    );
  }

  Widget _itemBuilder(BuildContext ctx, int index) {
    return new GestureDetector(
      onTap: () {
        _heroAnimation(data[index]);
      },
      child: new Card(
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  contactAvatar(data[index]),
                  contactDetails(data[index]),
                ],
              ),
            ],
          ),
          margin: EdgeInsets.all(10.0),
        ),
      ),
    );
  }

  void _heroAnimation(Company contact) {
    Navigator.of(context).push(
      new PageRouteBuilder<Null>(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return new AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child) {
                return new Opacity(
                  opacity: opacityCurve.transform(animation.value),
                  child: CompanyScreen(contact),
                );
              });
        },
      ),
    );
  }

  Widget contactAvatar(Company com) {
    return new Hero(
      tag: com.id,
      child: CachedNetworkImage(
        imageUrl: com.profile,
        height: 80,
        width: 80,
      ),
    );
  }

  Widget contactDetails(Company com) {
    return new Flexible(
        child: new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          textContainer(com.companyName, Colors.blue[400]),
          // textContainer(com., Colors.blueGrey[400]),
          // textContainer(contact.email, Colors.black),
        ],
      ),
      margin: EdgeInsets.only(left: 20.0),
    ));
  }

  Widget textContainer(String string, Color color) {
    return new Container(
      child: new Text(
        string,
        style: TextStyle(
            color: color, fontWeight: FontWeight.normal, fontSize: 16.0),
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new RefreshController();
  }

  void _onOffsetCallback(bool isUp, double offset) {
    // if you want change some widgets state ,you should rewrite the callback
    if (isUp) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Companies"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          alignment: Alignment.centerLeft,
          tooltip: 'Back',
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: new SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _controller,
          onRefresh: _onRefresh,
          headerBuilder: _headerCreate,
          footerBuilder: _footerCreate,
          footerConfig: new RefreshConfig(),
          onOffsetChange: _onOffsetCallback,
          child: ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: data.length,
            itemBuilder: _itemBuilder,
          )),
    );
  }
}
