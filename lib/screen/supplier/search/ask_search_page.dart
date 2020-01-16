import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask.dart';
import 'package:flutter_ecommerce/model/ask_product.dart';
import 'package:flutter_ecommerce/services/firestore_ask_products_service.dart';
import 'package:flutter_ecommerce/services/firestore_asks_service.dart';
import 'package:flutter_ecommerce/widgets/general_card.dart';

class AskSearchPage extends StatefulWidget {
  String searchKeyword;

  AskSearchPage({this.searchKeyword});

  _AskSearchPagePageState createState() => _AskSearchPagePageState();
}

class _AskSearchPagePageState extends State<AskSearchPage>
    with TickerProviderStateMixin {
  FirebaseFirestoreServiceAsks db = FirebaseFirestoreServiceAsks();
  FirebaseFirestoreServiceAskProducts pdb =
      FirebaseFirestoreServiceAskProducts();
  String _search_string = "";

  List<Ask> items = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    _search_string = widget.searchKeyword;
    searchProdcut(_search_string);
  }

  searchProdcut(String keyword) {
    items.clear();
    // if(keyword.length>0){
    db.getAskActiveList().listen((test) => test.documents.forEach((f) {
          Ask item = Ask.fromMap(f.data);

          if ((item.description + item.ask_title)
              .toLowerCase()
              .contains(keyword.toLowerCase())) {
            setState(() {
              items.add(item);
            });
          } else {
            pdb
                .getAskProcutsListByaID(item.id)
                .listen((onData) => onData.documents.forEach((g) {
                      AskProduct pitem = AskProduct.fromMap(g.data);
                      if (pitem.product_name
                          .toLowerCase()
                          .contains(keyword.toLowerCase())) {
                        setState(() {
                          items.add(item);
                        });
                        return;
                      }
                    }));
          }
        }));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          // IconButton(
          //   onPressed: (){},
          //   icon: Icon(Icons.favorite, color: Colors.grey.shade700,),
          // ),
        ],
        backgroundColor: Colors.white70,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.grey.shade700,
            )),
        title: Text(
          'Looking for Ask',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        bottom: _buildBottomBar(),
      ),
      body: SafeArea(
          child: GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 0.7,
        ),
        itemBuilder: _buildListView,
        itemCount: items.length,
      )
          // child:ListView(
          //   children: <Widget>[
          //     _buildListView(context, 0),
          //     _buildListView(context, 1),
          //   ],
          // ),
          ),
    );
  }

  PreferredSize _buildBottomBar() {
    final searchController = TextEditingController();
    searchController.text = _search_string;
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Card(
          child: Container(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                suffixIcon: IconButton(
                    onPressed: () {
                      searchProdcut(_search_string);
                    },
                    icon: Icon(Icons.send)),
              ),
              onChanged: (value) => _search_string = value,
            ),
          ),
        ),
      ),
      preferredSize: Size.fromHeight(80.0),
    );
  }

  Widget _buildListView(BuildContext context, int index) {
    return GeneralCard(
      ask: items[index],
    );
  }
}
