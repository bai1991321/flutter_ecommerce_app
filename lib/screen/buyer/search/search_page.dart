import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/model/product.dart';
import 'package:flutter_ecommerce/screen/buyer/Asks/ask_screen.dart';
import 'package:flutter_ecommerce/screen/buyer/cart/cart_page.dart';
import 'package:flutter_ecommerce/screen/buyer/payment/DetailScreen.dart';
import 'package:flutter_ecommerce/screen/buyer/product_page.dart';
import 'package:flutter_ecommerce/screen/company/company_screen.dart';
import 'package:flutter_ecommerce/services/firestore_product_service.dart';
import 'package:flutter_ecommerce/utils/navigation_router.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:flutter_ecommerce/widgets/easyShopCard.dart';
import 'package:flutter_ecommerce/widgets/shopBuilder.dart';
import 'package:flutter_ecommerce/screen/chat/chat_main.dart';
import './../payment/orderhistory_screen.dart';

class ProductSearchPage extends StatefulWidget {
  String searchKeyword;

  ProductSearchPage({this.searchKeyword});

  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class _ProductSearchPageState extends State<ProductSearchPage>
    with TickerProviderStateMixin {
  FirebaseFirestoreServiceProduct db = FirebaseFirestoreServiceProduct();
  List<Product> items = [];
  int _selectedIndex = 0;
  bool loading = true;
  String _searchKeyword;

  final drawerItems = [
    new DrawerItem("Home", Icons.dashboard),
    new DrawerItem("Asks", Icons.receipt),
    new DrawerItem("Profile", Icons.perm_contact_calendar),
    new DrawerItem("Messages", Icons.mail_outline),
    new DrawerItem("Payments", Icons.monetization_on)
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
      default:
        return new Text("Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    String _searchKeyword = widget.searchKeyword;
    searchProdcut(_searchKeyword);
  }

  searchProdcut(String keyword) {
    items.clear();
    db.getProductList().listen((test) => test.documents.forEach((f) {
          Product item = Product.fromMap(f.data);

          if (item.itemname.toLowerCase().contains(keyword.toLowerCase())) {
            setState(() {
              items.add(item);
            });
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => CartPage())),
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.grey.shade700,
            ),
          ),
        ],
        backgroundColor: Colors.white70,
        leading: IconButton(
            onPressed: () => scaffoldKey.currentState.openDrawer(),
            icon: Icon(
              Icons.menu,
              color: Colors.grey.shade700,
            )),
        title: Text(
          'Shopping',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        bottom: _buildBottomBar(),
      ),
      key: scaffoldKey,
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
      body: SafeArea(
        // child: ListView.builder(
        //   itemBuilder: _buildListView,
        //   itemCount: items==null?1:items.length + 1,
        // )
        child: ListView(
          children: <Widget>[
            _buildListView(context, 0),
            _buildListView(context, 1),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildBottomBar() {
    final searchController = TextEditingController();
    searchController.text = _searchKeyword;
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Card(
          child: Container(
            child: TextField(
              // initialValue: widget.searchKeyword==null?"":widget.searchKeyword,
              controller: searchController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        searchProdcut(_searchKeyword);
                      },
                      icon: Icon(Icons.send))),
              onChanged: (value) => _searchKeyword = value,
            ),
          ),
        ),
      ),
      preferredSize: Size.fromHeight(80.0),
    );
  }

  Widget _buildListView(BuildContext context, int index) {
    if (index == 0)
      return Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Search Result",
              style: TextStyle(fontSize: 18.0),
            ),
            Text("See All", style: TextStyle(color: Colors.grey.shade500)),
          ],
        ),
      );

    return ShopBuilder(
      height: 290.0,
      column: 2,
      children: items.where((p) => true).map((p) => _cardGenerater(p)).toList(),
    );
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
      supplierName: p.supplier,
      badgeBgColor: Colors.orange,
      height: 180.0,
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
}
