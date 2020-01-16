import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/Category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/services/firestore_category_service.dart';
import 'products/products_list_page.dart';

class SubCategoryPage extends StatefulWidget {
  final Category child;

  SubCategoryPage({Key key, this.child}) : super(key: key);

  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  FirebaseFirestoreServiceCategory subDB =FirebaseFirestoreServiceCategory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.amber,
            expandedHeight: 175.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('SubCategories'),
              background: Stack(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    width: double.infinity,
                    color: Colors.orange,
                  ),
                  Positioned(
                      bottom: 150,
                      left: -40,
                      child: Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            color: Colors.yellowAccent[100].withOpacity(0.1)),
                      )),
                  Positioned(
                      top: -120,
                      left: 100,
                      child: Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            color: Colors.yellowAccent[100].withOpacity(0.1)),
                      )),
                  Positioned(
                      top: -50,
                      left: 0,
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.yellowAccent[100].withOpacity(0.1)),
                      )),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(75),
                            color: Colors.yellowAccent[100].withOpacity(0.1)),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StreamBuilder<QuerySnapshot>(
              stream: subDB.getSubCategoryList(widget.child.id),
              builder:(ctx, snap){
                switch (snap.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator(),);
                    break;
                  default: return new  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snap.data.documents.length,
                      itemBuilder: (context, index) {
                        Category cate =Category.fromMap(snap.data.documents[index].data);
                        cate.id =snap.data.documents[index].documentID;
                        return _createListTile(cate);
                        },
                      );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createListTile(Category category){
    return Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 8),
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  elevation: 5.0,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 70,
                          child: Image.network(
                              "https://cdn.shopify.com/s/files/1/0104/6937/6058/products/1500x1941_Cactus_coleccion_1_en_maceta_de_ceramica_color_blanco-2_1024x1024.jpg?v=1532302961"),
                        ),
                        InkWell(onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProductsListPage(category: category,)),
                          );
                        },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    width: 220,
                                    child: Text(
                                      category.name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
  }
}