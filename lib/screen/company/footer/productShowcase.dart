import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/product.dart';
import 'package:flutter_ecommerce/services/firestore_product_service.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:flutter_ecommerce/screen/supplier/item_reviews_page.dart';

class ProductShowcase extends StatefulWidget {
  _ProductShowcaseState createState() => _ProductShowcaseState();
}

class _ProductShowcaseState extends State<ProductShowcase>
    with TickerProviderStateMixin {
  FirebaseFirestoreServiceProduct pdb = FirebaseFirestoreServiceProduct();
  List<Product> product_list;

  @override
  void initState() {
    super.initState();
    var lists = new List<Product>();
    pdb
        .getProductsListByID(Util.uid)
        .listen((data) => data.documents.forEach((f) {
              lists.add(Product.fromMap(f.data));
              setState(() {
                this.product_list = lists;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    var delegate = new SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
    );

    // return new GridView(
    //   padding: const EdgeInsets.only(top: 16.0),
    //   gridDelegate: delegate,
    //   children: _buildItems(),
    // );
    return GridView.builder(
      padding: const EdgeInsets.only(top: 16.0),
      gridDelegate: delegate,
      itemCount: product_list != null ? product_list.length : 0,
      itemBuilder: (ctx, index) {
        return new ClipRRect(
          borderRadius: new BorderRadius.circular(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ItemReviewsPage(product_list.toList()[index])));
            },
            child: CachedNetworkImage(
            imageUrl: product_list.toList()[index].imageUrl[0],
          ),
        ));
      },
    );
  }
}
// ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     itemCount:this.product_list==null?0: this.product_list
//                         .length,
//                     itemBuilder: (ctx, index) {
//                       return BadShopItem(product_list
//                           .toList()[index]);
//                     }),
