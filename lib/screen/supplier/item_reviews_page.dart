import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/product.dart';
import 'package:flutter_ecommerce/services/firestore_category_service.dart';
import 'package:flutter_ecommerce/model/Category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_product_page.dart';

class ItemReviewsPage extends StatefulWidget {
  final Product product;

  const ItemReviewsPage(this.product);

  @override
  _ItemReviewsPageState createState() => _ItemReviewsPageState();
}

class _ItemReviewsPageState extends State<ItemReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 170.0,
            backgroundColor: Colors.red,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.product.itemname),
              background: SizedBox.expand(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Hero(
                      tag: "product_${widget.product.id}",
                      child: CachedNetworkImage(
                        imageUrl: widget.product.imageUrl[0],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Container(color: Colors.black26)
                  ],
                ),
              ),
            ),
            elevation: 2.0,
            forceElevated: true,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              /// Rating average
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 16.0),
                  child: Text('4.6',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 64.0)),
                ),
              ),

              /// Rating stars
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.amber, size: 48.0),
                    Icon(Icons.star, color: Colors.amber, size: 48.0),
                    Icon(Icons.star, color: Colors.amber, size: 48.0),
                    Icon(Icons.star, color: Colors.amber, size: 48.0),
                    Icon(Icons.star, color: Colors.black12, size: 48.0),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Price'),
                trailing: Text('\$${widget.product.price}'),
              ),
              ListTile(
                leading: Text('Category:'),
                title: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestoreServiceCategory().getCategoryByID(widget.product.category),
                  builder: (context, snap){
                    switch (snap.connectionState) {
                      case ConnectionState.waiting:
                        return Text('Loading...');
                        break;
                      default:
                      if (snap.data.documents.length==0)  return Text("Unkown! Please complete Product Infomation");
                        return Text('${Category.map(snap.data.documents[0].data).name}');
                    }
                  },
                ),
              ),
              ListTile(
                leading: Text('SubCategory:'),
                title: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestoreServiceCategory().getSubCategoryByID(widget.product.category, widget.product.subcategory),
                  builder: (context, snap){
                    switch (snap.connectionState) {
                      case ConnectionState.waiting:
                        return Text('Loading...');
                        break;
                      default:
                        if (!snap.data.exists)  return Text("Unkown! Please complete Product Infomation");
                        return Text('${Category.fromMap(snap.data.data).name}');
                    }
                  },
                ),
              ),
              ListTile(
                title: Text('Dimension'),
                trailing: Text('${widget.product.length}🞨${widget.product.width}🞨${widget.product.height}'),
                subtitle: Text('Distance Uint: ${widget.product.mass_unit}'),
              ),
              ListTile(
                title: Text('Weight'),
                trailing: Text(widget.product.weight),
                subtitle: Text('Mass Unit: ${widget.product.mass_unit}'),
              ),
              ListTile(
                title: Text('Description'),
                subtitle: Text(widget.product.description),
              )

              /// Review
              // Padding
              // (
              //   padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              //   child: Material
              //   (
              //     elevation: 12.0,
              //     color: Colors.white,
              //     borderRadius: BorderRadius.only
              //     (
              //       topRight: Radius.circular(20.0),
              //       bottomLeft: Radius.circular(20.0),
              //       bottomRight: Radius.circular(20.0),
              //     ),
              //     child: Container
              //     (
              //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              //       child: Container
              //       (
              //         child: ListTile
              //         (
              //           leading: CircleAvatar
              //           (
              //             backgroundColor: Colors.purple,
              //             child: Text('AI'),
              //           ),
              //           title: Text('Ivascu Adrian ★★★★★', style: TextStyle()),
              //           subtitle: Text('The shoes were shipped one day before the shipping date, but this wasn\'t at all a problem :). The shoes are very comfortable and good looking.', style: TextStyle()),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // /// Review reply
              // Padding
              // (
              //   padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              //   child: Row
              //   (
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: <Widget>[
              //       Material
              //       (
              //         elevation: 12.0,
              //         color: Colors.tealAccent,
              //         borderRadius: BorderRadius.only
              //         (
              //           topLeft: Radius.circular(20.0),
              //           bottomLeft: Radius.circular(20.0),
              //           bottomRight: Radius.circular(20.0),
              //         ),
              //         child: Container
              //         (
              //           margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              //           child: Text('Happy to hear that!', style: Theme.of(context).textTheme.subhead),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Divider(),
              // /// Review
              // Padding
              // (
              //   padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              //   child: Material
              //   (
              //     elevation: 12.0,
              //     color: Colors.white,
              //     borderRadius: BorderRadius.only
              //     (
              //       topRight: Radius.circular(20.0),
              //       bottomLeft: Radius.circular(20.0),
              //       bottomRight: Radius.circular(20.0),
              //     ),
              //     child: Container
              //     (
              //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              //       child: Column
              //       (
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: <Widget>
              //         [
              //           Container
              //           (
              //             child: ListTile
              //             (
              //               leading: CircleAvatar
              //               (
              //                 backgroundColor: Colors.purple,
              //                 child: Text('AI'),
              //               ),
              //               title: Text('Ivascu Adrian ★★★★★', style: TextStyle()),
              //               subtitle: Text('The shoes were shipped one day before the shipping date, but this wasn\'t at all a problem :). The shoes are very comfortable and good looking', style: TextStyle()),
              //             ),
              //           ),
              //           Padding
              //           (
              //             padding: EdgeInsets.only(top: 4.0, right: 10.0),
              //             child: FlatButton.icon
              //             (
              //               onPressed: () {},
              //               icon: Icon(Icons.reply, color: Colors.blueAccent),
              //               label: Text('Reply', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w700, fontSize: 16.0))
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Divider(),
              // /// Review
              // Padding
              // (
              //   padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              //   child: Material
              //   (
              //     elevation: 12.0,
              //     color: Colors.white,
              //     borderRadius: BorderRadius.only
              //     (
              //       topRight: Radius.circular(20.0),
              //       bottomLeft: Radius.circular(20.0),
              //       bottomRight: Radius.circular(20.0),
              //     ),
              //     child: Container
              //     (
              //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              //       child: Column
              //       (
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: <Widget>
              //         [
              //           Container
              //           (
              //             child: ListTile
              //             (
              //               leading: CircleAvatar
              //               (
              //                 backgroundColor: Colors.purple,
              //                 child: Text('AI'),
              //               ),
              //               title: Text('Ivascu Adrian ★★★★★', style: TextStyle()),
              //               subtitle: Text('The shoes were shipped one day before the shipping date, but this wasn\'t at all a problem :). The shoes are very comfortable and good looking', style: TextStyle()),
              //             ),
              //           ),
              //           Padding
              //           (
              //             padding: EdgeInsets.only(top: 4.0, right: 10.0),
              //             child: FlatButton.icon
              //             (
              //               onPressed: () {},
              //               icon: Icon(Icons.reply, color: Colors.blueAccent),
              //               label: Text('Reply', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w700, fontSize: 16.0))
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit, color: Colors.white,),
        onPressed: (){
          Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => EditProductPage(child: widget.product,)));
        },
      ),
    );
  }
}
