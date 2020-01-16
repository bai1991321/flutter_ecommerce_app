import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/category_filter.dart';
import 'sub_category_page.dart';
import 'package:flutter_ecommerce/services/firestore_category_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter_ecommerce/model/Category.dart';

class CategoryPage extends StatefulWidget {
  // final Category category;

  // CategoryPage(this.category);

  @override
  CategoryPageState createState() {
    return new CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage> {
  CategoryFilter filter = CategoryFilter("", SortBy.AZ);
  TextEditingController textEditingController = TextEditingController();
  SortBy sortBy;
  FirebaseFirestoreServiceCategory categoryDB =FirebaseFirestoreServiceCategory();
  RandomColor _randomColor = RandomColor();
  @override
  void initState() {
    sortBy = filter.sort;
    super.initState();
  }

  void changeSort(SortBy newSort) {
    setState(() {
      sortBy = newSort;
    });
  }

  void filterResults(CategoryFilter newFilter) {
    setState(() {
      filter = newFilter;
      textEditingController.text = newFilter.searchTerm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.amber,
            expandedHeight: 175.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Categories'),
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
            child: SafeArea(
              child: StreamBuilder<QuerySnapshot>(
              stream: categoryDB.getCategoryList(),
              builder:(ctx, snap){
                switch (snap.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator(),);
                    break;
                  default: return new OrientationBuilder(
                    builder: (context, orientation) {
                    return new GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      
                      itemCount: snap.data.documents.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                      itemBuilder: (context, index) {
                        Category cate =Category.fromMap(snap.data.documents[index].data);
                        return createTile(index, _selectedIndex, index%2==0, cate, _randomColor.randomColor(
                              colorBrightness: ColorBrightness.light), Icons.image);
                        },
                      );
                    }
                  );
                }
              },
            )),
          ),
          //
        ],
      ),
    );
  }

  

  int _selectedIndex = -1;

  Widget createTile(int index, int selectedIndex, bool isEven, Category title,
      Color color, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(
          left: isEven ? 10 : 20, right: isEven ? 20 : 10, top: 10, bottom: 10),
      child: Card(
        // width: MediaQuery.of(context).size.width,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SubCategoryPage(
                      child: title,
                    ),
              ));
            });
          },
          child: Material(
            elevation: 3.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, bottom: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Icon(
                      icon,
                      color: color,
                      size: 50,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title.name,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Container(
                          height: 3.0,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: color,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}
