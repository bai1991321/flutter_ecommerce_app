import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask_product.dart';
import 'package:flutter_ecommerce/model/bid.dart';
import 'package:flutter_ecommerce/model/product.dart';
import 'package:flutter_ecommerce/screen/supplier/asks/bid_product_page.dart';
import 'package:flutter_ecommerce/services/firestore_product_service.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:flutter_ecommerce/widgets/custom_app_bar.dart';
import 'package:flutter_ecommerce/widgets/product_list_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BidSelectableListFragment extends StatefulWidget {
  AskProduct askProduct;
  Bid bid;

  BidSelectableListFragment(this.askProduct, {this.bid});

  _BidSelectableListFragmentState createState() =>
      _BidSelectableListFragmentState();
}

class _BidSelectableListFragmentState extends State<BidSelectableListFragment>
    with TickerProviderStateMixin {
  FirebaseFirestoreServiceProduct db = FirebaseFirestoreServiceProduct();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  RefreshController _controller;
  String searchTerm = "";
  List<Product> data = [];
  int indexPage = 0;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetch();
    _controller = new RefreshController();
  }

  void _onOffsetCallback(bool isUp, double offset) {
    // if you want change some widgets state ,you should rewrite the callback
    if (isUp) {
    } else {}
  }

  void _fetch() {
    db
        .getProductsListByID(Util.uid, offset: indexPage, limit: 10)
        .listen((onData) => onData.documents.forEach((f) {
              Product product = Product.map(f.data);

              setState(() {
                data.add(product);
                _controller.sendBack(false, RefreshStatus.idle);
                indexPage++;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar((s) {
        setState(() {
          searchTerm = s;
        });
      }, scaffoldKey),
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
            itemCount: searchTerm == ""
                ? data.length
                : data
                    .where((p) => p.itemname
                        .toLowerCase()
                        .contains(searchTerm.toLowerCase()))
                    .length,
            itemBuilder: _itemBuilder,
          )),
    );
  }

  Widget _itemBuilder(BuildContext ctx, int index) {
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (ctx) => BidProductPage(
                  widget.askProduct,
                  product: data[index],
                )));
      },
      child: ProductListItem(data
          .where((p) =>
              p.itemname.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList()[index]),
    );
  }
}
