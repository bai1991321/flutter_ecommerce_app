import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask_product.dart';
import 'package:flutter_ecommerce/model/bid.dart';
import 'package:flutter_ecommerce/model/product.dart';
import 'package:flutter_ecommerce/services/firestore_bids_service.dart';
import 'package:flutter_ecommerce/utils/form_validate.dart';
import 'package:flutter_ecommerce/utils/util.dart';
// import 'package:flutter_ecommerce/widgets/image_picker_handler.dart';

class BidProductPage extends StatefulWidget {
  AskProduct askProduct;

  Product product;
  Bid bid;

  BidProductPage(this.askProduct, {this.product, this.bid});

  _BidProductPageState createState() => _BidProductPageState();
}

class _BidProductPageState extends State<BidProductPage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  // ImagePickerHandler imagePicker;
  // File _image;
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestoreServiceBids db = FirebaseFirestoreServiceBids();
  String _image_url;
  String _bid_title;
  String _amount;
  String _quantity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.product != null)
      _image_url = widget.product.imageUrl[0];
    else if (widget.bid != null)
      _image_url = widget.bid.imageURL;
    else
      _image_url = null;

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // imagePicker=new ImagePickerHandler(this,_controller);
    // imagePicker.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  userImage(File image) {
    // TODO: implement userImage
    setState(() {
      // this._image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Bid Product'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: new Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                //new SizedBox(height: _height/12,),
                new GestureDetector(
                  // onTap: () => imagePicker.showDialog(context),
                  child: new Center(
                    child: new Container(
                      height: 160.0,
                      width: 160.0,
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: new DecorationImage(
                          image:
                              new CachedNetworkImageProvider(_image_url ?? ""),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.red, width: 5.0),
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(80.0)),
                      ),
                    ),
                  ),
                ),
                new SizedBox(
                  height: _height / 25.0,
                ),
                new Text(
                  widget.askProduct.product_name,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _width / 15,
                      color: Colors.white),
                ),
                new Text(
                  widget.bid == null
                      ? widget.product.itemname
                      : widget.bid.bid_title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  // decoration: InputDecoration(

                  //   fillColor: Colors.black,
                  //   labelText: 'Bid Title',
                  //   border: OutlineInputBorder(),
                  //   prefixIcon: Icon(Icons.event_note),
                  // ),
                  // maxLength: 100,
                  // maxLines: 3,
                  // keyboardType: TextInputType.text,
                  // initialValue: widget.askProduct != null && widget.askProduct.product_name.isNotEmpty
                  //     ? widget.askProduct.product_name
                  //     : "",
                  // validator: FormValidate().validateMustInput,
                  // onSaved: (value) => _bid_title = value,
                ),
                new Divider(
                  height: _height / 30,
                  color: Colors.white,
                ),
                new Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        initialValue:
                            widget.bid == null ? '' : widget.bid.quantity,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.straighten),
                        ),
                        maxLength: 10,
                        keyboardType:
                            TextInputType.numberWithOptions(signed: false),
                        // initialValue: widget.askProduct != null && widget.askProduct.quantity.isNotEmpty
                        //     ? widget.askProduct.quantity
                        //     : "",
                        validator: FormValidate().validatePrice,
                        onSaved: (value) => _quantity = value,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue:
                            widget.bid == null ? '' : widget.bid.amount,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        maxLength: 10,
                        keyboardType:
                            TextInputType.numberWithOptions(signed: false),
                        // initialValue: widget.askProduct != null && widget.askProduct.budget.isNotEmpty
                        //     ? '\$'+widget.askProduct.budget
                        //     : "",
                        validator: FormValidate().validatePrice,
                        onSaved: (value) =>
                            _amount = value.replaceAll("\$", ''),
                      ),
                    )
                  ],
                ),
                new Divider(height: _height / 30, color: Colors.white),
                new Padding(
                  padding:
                      new EdgeInsets.only(left: _width / 8, right: _width / 8),
                  child: new FlatButton(
                    onPressed: onClickBidNow,
                    child: new Container(
                        child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.person),
                        new SizedBox(
                          width: _width / 30,
                        ),
                        widget.bid == null
                            ? new Text('BID NOW')
                            : new Text('UPDATE'),
                      ],
                    )),
                    color: Colors.amber,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future onClickBidNow() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (widget.bid == null) {
        // _image_url = await _uploadFile();
        db.createBid(
            "${new Random().nextInt(10000)}${new Random().nextInt(10000)}${new Random().nextInt(10000)}${new Random().nextInt(10000)}",
            Util.uid,
            widget.askProduct.askId,
            widget.askProduct.id,
            widget.askProduct.buyerId,
            _bid_title,
            _quantity,
            _amount,
            _image_url,
            widget.product.id);
        Navigator.pop(context);
      } else {
        // if(_image != null){
        //   //Fluttertoast.showToast(msg: "Please select your product image.", toastLength: Toast.LENGTH_SHORT);
        //   _image_url = await _uploadFile();
        //  // return;
        // }else _image_url = widget.bid.imageURL;
        widget.bid.setBid_title(_bid_title);
        widget.bid.setAmount(_amount);
        widget.bid.setQuantity(_quantity);
        widget.bid.setImageURL(_image_url);
        db.updateBid(widget.bid);
        Navigator.pop(context);
      }
    }
  }

// Future<String> _uploadFile() async {
//   final String rand1 = "${new Random().nextInt(10000)}";
//   final String rand2 = "${new Random().nextInt(10000)}";
//   final String rand3 = "${new Random().nextInt(10000)}";
//   final StorageReference ref = FirebaseStorage.instance.ref().child(Util.uid).child("bid_files").child('${rand1}_${rand2}_${rand3}.jpg');
//   final StorageUploadTask uploadTask = ref.putFile(
//     // _image,
//     StorageMetadata(
//       contentLanguage: 'en',
//       contentType: "image/jpeg"
//     ),
//   );

//   final downloadURL = await (await uploadTask.onComplete).ref.getDownloadURL();
//   print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${downloadURL.toString()}");
//   return downloadURL.toString();
// }
}
