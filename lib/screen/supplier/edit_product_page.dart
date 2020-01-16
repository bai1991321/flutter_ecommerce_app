import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:flutter_ecommerce/model/product.dart';
import 'package:flutter_ecommerce/model/Category.dart';
import 'package:flutter_ecommerce/widgets/image_picker_handler.dart';
import 'package:flutter_ecommerce/services/firestore_category_service.dart';
import 'package:flutter_ecommerce/services/firestore_product_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_ecommerce/utils/form_validate.dart';


class EditProductPage extends StatefulWidget {
  final Product child;

  EditProductPage({Key key, this.child}) : super(key: key);

  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  List<Category> _categories = [];
  List<Category> _subcategories = [];
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  String _productName,
      _productPrice,
      _productamount,
      _productDescription,
      _product_id,
      _category = '',
      _subcategory,
      _productImgeURL,
      _length,
      _width,
      _height,
      _weight;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _distance_unit, _mass_unit;
  TextEditingController _productNameC,
      _productPriceC,
      _productamountC,
      _productDescriptionC,
      _lengthC,
      _widthC,
      _heightC,
      _weightC;


  List<DropdownMenuItem<String>> getDropDownMenuDistenceItems() {
    List _cities = ["cm", "in", "ft", "mm", "m", "yd"];
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuUnitItems() {
    List _cities = ["g", "oz", "lb", "kg"];
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _distance_unit = 'cm';
    _mass_unit = 'g';
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    

    this._subcategory =widget.child.subcategory;
    this._productName = widget.child.itemname;
    this._productPrice =widget.child.price;
    this._productamount =widget.child.amount;
    this._category = widget.child.category;
    this._subcategory =widget.child.subcategory;
    this._productImgeURL = widget.child.imageUrl[0];
    this._productDescription =widget.child.description;
    this._length =widget.child.length;
    this._width =widget.child.width;
    this._height =widget.child.height;
    this._distance_unit = widget.child.distance_unit;
    this._mass_unit = widget.child.mass_unit;
    this._weight =widget.child.weight;

    _loadCategories();
    _loadSubCategories(widget.child.category);

    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
    _productNameC = TextEditingController(text: widget.child.itemname);
    _productPriceC = TextEditingController(text: widget.child.price);
    _productamountC = TextEditingController(text: widget.child.amount);
    _productDescriptionC = TextEditingController(text: widget.child.description);
    // _product_idC = TextEditingController();
    // _productImgeURLC = TextEditingController();
    _lengthC = TextEditingController(text: widget.child.length);
    _widthC = TextEditingController(text: widget.child.width);
    _heightC = TextEditingController(text: widget.child.height);
    _weightC = TextEditingController(text: widget.child.weight);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  _loadCategories(){
    FirebaseFirestoreServiceCategory().getCategoryList().listen((onData) {
      setState(() {
        this._categories =onData.documents.map((f) => Category.fromMap(f.data)).toList();
        if (this._category.length<5) this._category = Category.fromMap(onData.documents[0].data).id;
      });
    });
  }

  _loadSubCategories(String id){
    FirebaseFirestoreServiceCategory().getSubCategoryList(id).listen((onData) {
      setState(() {
        this._subcategories =onData.documents.map((f) {
          Category data = Category.fromMap(f.data);
          data.id = f.documentID;
          return data;
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: new AppBar(
        title: new Text("Add Product"),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.save), onPressed: _onPressSaveProduct)
        ],
      ),
      body: new Form(
        key: _formKey,
        child: new ListView(
          children: <Widget>[
            new GestureDetector(
              onTap: () => imagePicker.showDialog(context),
              child: new Center(
                child: _image == null
                    ? new Stack(
                        children: <Widget>[
                          new Center(
                            child: new CircleAvatar(
                              radius: 80.0,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: NetworkImage(this._productImgeURL),
                            ),
                          ),
                        ],
                      )
                    : new Container(
                        height: 160.0,
                        width: 160.0,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: new ExactAssetImage(_image.path),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: Colors.red, width: 5.0),
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(80.0)),
                        ),
                      ),
              ),
            ),
            new ListTile(
              // leading: const Icon(Icons.card_giftcard),
              title: new TextFormField(
                // initialValue: this._productName,
                maxLength: 20,
                decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Product Name",
                    prefixIcon: const Icon(Icons.card_giftcard)),
                validator: _validateProductName,
                onSaved: (String value) {
                  _productName = value;
                },
                controller: _productNameC,
              ),
            ),
            new ListTile(
              // leading: const Icon(MdiIcons.cashUsd),
              title: new TextFormField(
                // initialValue: this._productPrice,
                keyboardType: TextInputType.numberWithOptions(signed: false),
                maxLength: 10,
                decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Price",
                    prefixIcon: const Icon(MdiIcons.cashUsd)),
                validator: FormValidate().validatePrice,
                onSaved: (String value) {
                  _productPrice = value;
                },
                controller: _productPriceC,
              ),
            ),
            new ListTile(
              // leading: const Icon(MdiIcons.cashUsd),
              title: new TextFormField(
                // initialValue: this._productamount,
                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                maxLength: 10,
                decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "amount",
                    prefixIcon: const Icon(Icons.queue)),
                validator: FormValidate().validatePrice,
                onSaved: (String value) {
                  _productamount = value;
                },
                controller: _productamountC,
              ),
            ),
            new ListTile(
              leading: Text('Category'),
              title: _categories.length < 1 ? Text('Loading...'): new DropdownButton(
                 isDense: true,
                value: _category,
                items: _categories.map((f) => DropdownMenuItem(value: f.id, child: SizedBox(width: 200,child:Text(f.name,softWrap: false,
                          overflow: TextOverflow.fade)),)).toList(),
                onChanged: (value) {
                  _loadSubCategories(value);
                  setState(() {
                    _category = value;
                  });
                },
              ),
            ),
            new ListTile(
              enabled: _category.length > 0,
              leading: Text('SubCategory'),
              title: _subcategories.length == 0 ? Text('Select a category'): new DropdownButton(
                value: _subcategory,
                items: _subcategories.map((f) => DropdownMenuItem(value: f.id, child: Text(f.name),)).toList(),
                onChanged: (value) {
                  setState(() {
                    _subcategory = value;
                  });
                },
              ),
            ),
            new ListTile(
              // leading: const Icon(MdiIcons.commentMultipleOutline),
              title: new TextFormField(
                // initialValue: this._productDescription,
                maxLength: 2000,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Description",
                    prefixIcon: const Icon(MdiIcons.commentMultipleOutline)),
                // validator: _validateProductDescription,
                onSaved: (String value) {
                  _productDescription = value;
                },
                controller: _productDescriptionC,
              ),
            ),
            const Divider(
              height: 1.0,
            ),
            new ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Contact group'),
              subtitle: const Text('Not specified'),
            ),
            const Divider(
              height: 1.0,
            ),
            new ListTile(
              leading: Text("Distance Unit"),
              title: new DropdownButton(
                value: _distance_unit,
                items: getDropDownMenuDistenceItems(),
                onChanged: (value) {
                  setState(() {
                    _distance_unit = value;
                  });
                },
              ),
            ),
            new ListTile(
              // leading: ,
              title: new TextFormField(
                // initialValue: this._length,
                maxLength: 5,
                decoration: new InputDecoration(
                  prefixIcon: const Icon(MdiIcons.tableEdit),
                  hintText: "Length",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(),
                onSaved: (String value) {
                  _length = value;
                },
                validator: FormValidate().validatePrice,
                controller: _lengthC,
              ),
              trailing: Text(_distance_unit),
            ),
            new ListTile(
              // leading: ,
              title: new TextFormField(
                // initialValue: this._width,
                maxLength: 5,
                decoration: new InputDecoration(
                  prefixIcon: const Icon(MdiIcons.tableColumnWidth),
                  hintText: "width",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(),
                onSaved: (String value) {
                  _width = value;
                },
                validator: FormValidate().validatePrice,
                controller: _widthC,
              ),
              trailing: Text(_distance_unit),
            ),
            new ListTile(
              // leading: const Icon(MdiIcons.tableRowHeight),
              title: new TextFormField(
                // initialValue: this._height,
                maxLength: 5,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(MdiIcons.tableRowHeight),
                  hintText: "Height",
                ),
                keyboardType: TextInputType.numberWithOptions(),
                onSaved: (String value) {
                  _height = value;
                },
                validator: FormValidate().validatePrice,
                controller: _heightC,
              ),
              trailing: Text(_distance_unit),
            ),
            new ListTile(
              leading: Text("Mass Unit"),
              title: new DropdownButton(
                value: _mass_unit,
                items: getDropDownMenuUnitItems(),
                onChanged: (value) {
                  setState(() {
                    _mass_unit = value;
                  });
                },
              ),
            ),
            new ListTile(
              // leading: const Icon(MdiIcons.weight),
              title: new TextFormField(
                // initialValue: this._weight,
                maxLength: 5,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(MdiIcons.weight),
                  hintText: "weight",
                ),
                keyboardType: TextInputType.numberWithOptions(),
                onSaved: (String value) {
                  _weight = value;
                },
                validator: FormValidate().validatePrice,
                controller: _weightC,
              ),
              trailing: Text(_mass_unit),
            ),
          ],
        ),
      ),
    );
  }

   @override
  userImage(File image) {
    // TODO: implement userImage
    setState(() {
      this._image = image;
    });
  }

  String _validateProductName(String value) {
    if (!(value.length > 1)) {
      return 'The Product name must be required.';
    }
    return null;
  }

  String _validateProductDescription(String value) {
    if (!(value.length > 19)) {
      return 'The Product description must be at least 20 characters.';
    }
    return null;
  }

  Future<String> _onPressSaveProduct() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_image != null) {
        _productImgeURL = await _uploadFile();
      }
      
      if (_category.isEmpty||_subcategory.isEmpty){
        Fluttertoast.showToast(msg: 'Please select the Product category!');
        return "Product category taken error!";
      }

      FirebaseFirestoreServiceProduct db = FirebaseFirestoreServiceProduct();
      widget.child.amount = this._productamount;
      widget.child.category = this._category;
      widget.child.description = this._productDescription;
      widget.child.distance_unit = this._distance_unit;
      widget.child.height = this._height;
      widget.child.imageUrl[0] = this._productImgeURL;
      widget.child.itemname = this._productName;
      widget.child.length = this._length;
      widget.child.mass_unit = this._mass_unit;
      widget.child.preprice =widget.child.price;
      widget.child.price = this._productPrice;
      widget.child.subcategory = this._subcategory;
      widget.child.weight = this._weight;
      widget.child.width  =this._width;

      db.updateProduct(widget.child);

      Navigator.pop(context);
    }
  }

  Future<String> _uploadFile() async {
    final String rand1 = "${new Random().nextInt(10000)}";
    final String rand2 = "${new Random().nextInt(10000)}";
    final String rand3 = "${new Random().nextInt(10000)}";
    final StorageReference ref = FirebaseStorage.instance
        .ref()
        .child(Util.uid)
        .child("product_files")
        .child('${rand1}_${rand2}_${rand3}.jpg');
    final StorageUploadTask uploadTask = ref.putFile(
      _image,
      StorageMetadata(contentLanguage: 'en', contentType: "image/jpeg"),
    );

    final downloadURL =
        await (await uploadTask.onComplete).ref.getDownloadURL();
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${downloadURL.toString()}");
    return downloadURL.toString();
  }
}