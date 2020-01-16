// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/product.dart';
import 'package:flutter_ecommerce/model/wishlist.dart';
import 'package:flutter_ecommerce/services/firestore_company_service.dart';
import 'package:flutter_ecommerce/services/firestore_product_service.dart';
import 'package:flutter_ecommerce/utils/data.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:flutter_ecommerce/widgets/category_card_scroller.dart';
import 'package:flutter_ecommerce/widgets/custom_app_bar.dart';
import 'package:flutter_ecommerce/widgets/easyShopCard.dart';
import 'package:flutter_ecommerce/widgets/product_list_item.dart';
import 'package:flutter_ecommerce/widgets/shopBuilder.dart';

import 'bids/bid_history_page.dart';
import 'product_page.dart';

// import 'discover_fragment.dart';
// import "package:firebase_auth/firebase_auth.dart";
// import 'package:flutter_ecommerce/screen/fragment/category_page.dart';
// import 'package:flutter_ecommerce/widgets/hot_product_card.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class DiscoverScreen extends StatefulWidget {
  static WishList wishList = WishList();

  @override
  _DiscoverScreenState createState() => new _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String searchTerm = "";
  int _selectedIndex = 0;
  FirebaseFirestoreServiceCompany db = new FirebaseFirestoreServiceCompany();
  FirebaseFirestoreServiceProduct pdb = new FirebaseFirestoreServiceProduct();

  List<Product> shuffleAndReturn(List<Product> products) {
    List<Product> r = products;
    r.shuffle();
    return r;
  }

  final drawerItems = [
    new DrawerItem("My Profile", Icons.dvr),
    new DrawerItem("Company Info", Icons.account_balance),
    new DrawerItem("Bids", Icons.business_center),
    new DrawerItem("Log out", Icons.settings_power)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var lists = new List<Product>();
    pdb.getProductList().listen((data) => data.documents.forEach((f) {
          lists.add(Product.fromMap(f.data));
          setState(() {
            Data.products = lists;
          });
        }));
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
          // ]..addAll(drawerItems.map((c) => Container(
          //   child: InkWell(
          //     onTap: _onSelectItem(c),
          //     child: Container(
          //       margin: EdgeInsets.only(bottom: 16.0),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         children: <Widget>[
          //           Padding(
          //             padding: const EdgeInsets.only(left: 8.0),
          //             child: Icon(c.icon),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.only(left: 8.0),
          //             child: Text(c.title),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ))),
        ]),
      ),
      key: scaffoldKey,
      appBar: CustomAppBar((s) {
        setState(() {
          searchTerm = s;
        });
      }, scaffoldKey),
      body: searchTerm == ""
          ? ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Text(
                    "Category",
                    style: TextStyle(
                        fontWeight: FontWeight.w100, color: Color(0xff444444)),
                  ),
                ),
                CategoryCardScroller(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "recent Product",
                    style: TextStyle(
                        fontWeight: FontWeight.w100, color: Color(0xff444444)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ShopBuilder(
                    height: 290.0,
                    column: 2,
                    children: Data.products
                        .where((p) => true)
                        .map((p) => _cardGenerater(p))
                        .toList(),
                  ),
                )
              ],
            )
          : Container(
              child: ListView.builder(
                  itemCount: Data.products
                      .where((p) => p.itemname
                          .toLowerCase()
                          .contains(searchTerm.toLowerCase()))
                      .length,
                  itemBuilder: (ctx, index) {
                    return ProductListItem(Data.products
                        .where((p) => p.itemname
                            .toLowerCase()
                            .contains(searchTerm.toLowerCase()))
                        .toList()[index]);
                  }),
            ),
      // bottomNavigationBar: FancyTabBar(),
    );
  }

  _setDrawerItemWidget(int index) {
    switch (index) {
      case 0:
        // return Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DiscoverFragment()));//discover
        break;
      case 1:
        // return Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SettingFragment()));//company
        break;
      case 2:
        return Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => BidHistoryPage())); //product
        break;
      case 3:
        // return Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DashboardPage()));//logout
        break;

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop(); // close the drawer
    _setDrawerItemWidget(index);
  }

  EasyShopCard _cardGenerater(Product p) {
    return EasyShopCard(
      image: p.imageUrl[0],
      product_id: p.id,
      itemName: p.itemname,
      prePrice: p.preprice,
      price: p.price,
      rating: double.parse(p.rating),
      badge: p.badge,
      badgeBgColor: Colors.blue[400],
      height: 210.0,
      imageHeight: 140.0,
      // button: 'Buy',
      buttonColor: Colors.orange,
      buttonTextColor: Colors.white,
      btnOnPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => ProductPage(p))),
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => ProductPage(p))),
      favorited: false,
    );
  }

// CircleShopCard _comcardGenerater(Product p){
//     return  CircleShopCard(
//         image: NetworkImage(p.imageUrl),
//         company_id: p.id ,
//         itemName: p.itemname,
//         prePrice: p.preprice,
//         price: p.price,
//         rating: double.parse(p.rating),
//         badge: p.badge,
//         badgeBgColor: Colors.blue[400],
//         height: 210.0,
//         // imageHeight: 140.0,
//         // button: 'Buy',
//         buttonColor: Colors.orange,
//         buttonTextColor: Colors.white,
//         btnOnPressed: () => Navigator.of(context).push(MaterialPageRoute(
//             builder: (BuildContext context) => ProductPage(p))),
//         onTap: () => Navigator.of(context).push(MaterialPageRoute(
//            builder: (BuildContext context) => ProductPage(p))),
//         favorited: false,
//       );
// }

}
