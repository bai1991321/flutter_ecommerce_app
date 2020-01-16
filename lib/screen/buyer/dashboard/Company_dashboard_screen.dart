import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/screen/buyer/Asks/ask_input_fragment.dart';
import 'package:flutter_ecommerce/screen/buyer/Asks/ask_screen.dart';
import 'package:flutter_ecommerce/screen/buyer/products/products_list_page.dart';
import 'package:flutter_ecommerce/screen/buyer/recommend/category_suggest_page.dart';
import 'package:flutter_ecommerce/screen/buyer/search/search_page.dart';
import 'package:flutter_ecommerce/screen/chat/chat_main.dart';
import 'package:flutter_ecommerce/screen/company/company_screen.dart';
import 'package:flutter_ecommerce/utils/form_validate.dart';
import 'package:flutter_ecommerce/utils/navigation_router.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_ecommerce/utils/authentication.dart';

import './../../../flutter-shippo/screens/shippo_main.dart';
import './../payment/orderhistory_screen.dart';

class CompanyDashboardScreen extends StatefulWidget {
  _CompanyDashboardScreenState createState() => _CompanyDashboardScreenState();
}

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class _CompanyDashboardScreenState extends State<CompanyDashboardScreen> {
  final searchController = TextEditingController();
  int actualChart = 0;
  int _selectedIndex = 0;
  static final List<String> chartDropdownItems = [
    'Last 7 days',
    'Last month',
    'Last year'
  ];
  String actualDropdown = chartDropdownItems[0];

  final drawerItems = [
    new DrawerItem("Home", Icons.dashboard),
    new DrawerItem("Asks", Icons.receipt),
    new DrawerItem("Profile", Icons.perm_contact_calendar),
    new DrawerItem("Messages", Icons.mail_outline),
    new DrawerItem("Payments", Icons.monetization_on),
    new DrawerItem("Shipments", Icons.local_shipping),
    new DrawerItem("Logout", Icons.settings_power)
  ];

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop(); // close the drawer
    _setDrawerItemWidget(index);
  }

  _setDrawerItemWidget(int index) {
    switch (index) {
      case 0:
        return NavigationRouter.switchToBuyer(context); //dashboard
        break;
      case 1:
        return Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AskScreen())); //Asks
        break;
      case 2:
        return Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => CompanyScreen(new Company(
                Util.companyID,
                Util.companyname,
                Util.companyDescription,
                Util.companyPic,
                Util.type)))); //product
        break;
      case 3:
        return Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ChatMainScreen())); //logout
        break;
      case 4:
        return Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Oder_History()));
        break;
      case 5:
        return Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ShippoMainScreen()));
      case 6:
          Util.doClear();
          UserAuth().facebooklogOut();
          NavigationRouter.switchToLogin(context);
          break;
      default:
        return new Text("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(new Column(
        children: <Widget>[
          new ListTile(
            leading: new Icon(
              d.icon,
              color: Colors.redAccent,
            ),
            title: new Text(d.title,
                style: new TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold)),
            selected: i == _selectedIndex,
            onTap: () => _onSelectItem(i),
          ),
          new Divider(
            color: Colors.redAccent,
            height: 2.0,
          )
        ],
      ));
    }

    return Scaffold(
        drawer: Container(
          padding: EdgeInsets.only(left: 0.0, top: 0.0),
          width: 250.0,
          color: Colors.white,
          child: ListView(children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(Util.userName ?? ""),
              accountEmail: new Text(Util.emailId ?? ""),
              currentAccountPicture: new CircleAvatar(
                  maxRadius: 24.0,
                  backgroundColor: Colors.transparent,
                  child: new Center(
                    child: new Image.network(
                      Util.profilePic,
                      height: 58.0,
                      width: 58.0,
                    ),
                  )
                  // backgroundImage: new Image.network(src),
                  ),
            ),
            new Column(children: drawerOptions),
          ]),
        ),
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.redAccent,
          title: Text('Company Dashboard',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0)),
          centerTitle: true,
          // leading: IconButton
          // (
          //   color: Colors.white,
          //   onPressed: () => Navigator.of(context).pop(),
          //   icon: Icon(Icons.arrow_back, color: Colors.white),
          // ),
        ),
        body: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            _buildTile(
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Submit an Ask',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 26.0)),
                            Text('265K',
                                style: TextStyle(color: Colors.blueAccent)),
                          ],
                        ),
                        Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24.0),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(Icons.art_track,
                                  color: Colors.white, size: 30.0),
                            )))
                      ]),
                ), onTap: () {
              _showAskDialog();
            }),
            _buildTile(
              Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.search),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            hintText: "Search a product",
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0)),

                        // onChanged listener listens to every change to textfield
                        //              onChanged: (text){
                        //                print(text);
                        //              },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 100.0),
                        child: new Text("Go"),
                        color: Colors.amber,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProductSearchPage(
                                      searchKeyword: searchController.text)));
                          print(searchController.text);
                        },
                      ),
                    ],
                  )),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Material(
                          color: Colors.teal,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(Icons.account_balance,
                                color: Colors.white, size: 30.0),
                          )),
                      Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('Categories',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0)),
                      Text('All', style: TextStyle(color: Colors.black45)),
                    ]),
              ),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => CategorySuggestPage())),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Material(
                          color: Colors.amber,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.shopping_cart,
                                color: Colors.white, size: 30.0),
                          )),
                      Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('Products',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0)),
                      Text('All ', style: TextStyle(color: Colors.black45)),
                    ]),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ProductsListPage())),
            ),
            // _buildTile(
            //   Padding
            //       (
            //         padding: const EdgeInsets.all(24.0),
            //         child: Column
            //         (
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>
            //           [
            //             Row
            //             (
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: <Widget>
            //               [
            //                 Column
            //                 (
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: <Widget>
            //                   [
            //                     Text('Messages', style: TextStyle(color: Colors.green)),
            //                     Text('\$16K', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ],
            //         )
            //       ),
            // ),
            // _buildTile(
            //   Padding
            //   (
            //     padding: const EdgeInsets.all(24.0),
            //     child: Row
            //     (
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>
            //       [
            //         Column
            //         (
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>
            //           [
            //             Text('Payments', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
            //             Text('173', style: TextStyle(color: Colors.redAccent))
            //           ],
            //         ),
            //         Material
            //         (
            //           color: Colors.red,
            //           borderRadius: BorderRadius.circular(24.0),
            //           child: Center
            //           (
            //             child: Padding
            //             (
            //               padding: EdgeInsets.all(16.0),
            //               child: Icon(Icons.store, color: Colors.white, size: 30.0),
            //             )
            //           )
            //         )
            //       ]
            //     ),
            //   ),
            //   onTap:()=> Navigator.of(context).push(MaterialPageRoute(builder: (_) => Oder_History())),
            // )
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 120.0),
            StaggeredTile.extent(2, 150.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
            // StaggeredTile.extent(2, 220.0),
            // StaggeredTile.extent(2, 110.0),
          ],
        ));
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null ? () => onTap() : null,
            child: child));
  }

  void _showAskDialog() {
    // flutter defined function
    final titleKey = GlobalKey<FormState>();
    String str_title;
    Alert(
        context: context,
        title: "Project Name",
        content: Form(
          key: titleKey,
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            autofocus: true,
            maxLength: 20,
            keyboardType: TextInputType.text,
            validator: FormValidate().validateMustInput,
            onSaved: (value) => str_title = value,
          ),
        ),
        buttons: [
          new DialogButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          new DialogButton(
            child: new Text("Submit"),
            onPressed: () {
              if (titleKey.currentState.validate()) {
                titleKey.currentState.save();
                Navigator.of(context).pop();
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AskInputFragment(
                            ask_title: str_title,
                          )));
                });
              }
            },
          ),
        ]).show();
  }
}
