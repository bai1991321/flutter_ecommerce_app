import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/services/firestore_company_service.dart';
import 'package:flutter_ecommerce/utils/navigation_router.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:flutter_ecommerce/widgets/image_picker_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CompanyEditPage extends StatefulWidget {
  _CompanyEditPageState createState() => _CompanyEditPageState();
}

class _CompanyEditPageState extends State<CompanyEditPage>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  String _companytName, _companyDescription, _companyImgeURL;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('Buyer'),
    1: Text('Supplier'),
  };
  int selected_value = -1;
  bool is_new = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Util.type == '') {
      is_new = true;
      selected_value = 0;
    }

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Company Profile"),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.save), onPressed: _onPressSaveCompany)
        ],
        leading: SizedBox(),
      ),
      body: new Form(
        key: _formKey,
        child: new ListView(
          children: <Widget>[
            new GestureDetector(
              onTap: () => imagePicker.showDialog(context),
              child: new Center(
                child: _image == null && Util.companyPic.length < 5
                    ? new Stack(
                        children: <Widget>[
                          new Center(
                            child: new CircleAvatar(
                              radius: 80.0,
                              backgroundColor: const Color(0xFF778899),
                            ),
                          ),
                          new Center(
                            child: new Image.asset("assets/photo_camera.png"),
                          ),
                        ],
                      )
                    : new Container(
                        height: 160.0,
                        width: 160.0,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: _image != null
                                ? new ExactAssetImage(_image.path)
                                : NetworkImage(Util.companyPic),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: Colors.red, width: 5.0),
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(80.0)),
                        ),
                      ),
              ),
            ),
            is_new
                ? CupertinoSegmentedControl<int>(
                    selectedColor: Colors.blue,
                    unselectedColor: Colors.white,
                    pressedColor: Colors.grey[200],
                    children: logoWidgets,
                    onValueChanged: (int val) {
                      setState(() {
                        selected_value = val;
                      });
                    },
                    groupValue: selected_value,
                  )
                : SizedBox(),
            new ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: new TextFormField(
                maxLength: 20,
                decoration: new InputDecoration(
                  hintText: "Company Name",
                ),
                validator: _validateProductName,
                onSaved: (String value) {
                  _companytName = value;
                },
              ),
            ),
            new ListTile(
              leading: const Icon(MdiIcons.cashUsd),
              title: new TextFormField(
                maxLength: 2000,
                keyboardType: TextInputType.multiline,
                decoration: new InputDecoration(
                  hintText: "Please input your company description.",
                ),
                validator: _validateProductDescription,
                onSaved: (String value) {
                  _companyDescription = value;
                },
              ),
            ),
            const Divider(
              height: 1.0,
            ),
            new ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Contact group'),
              subtitle: const Text('Not specified'),
            )
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

  Future<String> _onPressSaveCompany() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (_image == null) {
        if (Util.companyPic.length < 5) {
          Fluttertoast.showToast(
            msg: "Please take your Company photo.",
            toastLength: Toast.LENGTH_SHORT,
          );
          return "Company Image taken error!";
        }
        _companyImgeURL = Util.companyPic;
      } else {
        _companyImgeURL = await _uploadFile();
      }
      if (selected_value == 0) Util.type = "buyer";
      if (selected_value == 1) Util.type = "supplier";

      FirebaseFirestoreServiceCompany db = FirebaseFirestoreServiceCompany();
      if (Util.companyID.length < 5)
        db
            .createCompany(
          Util.uid,
          _companytName,
          _companyDescription,
          _companyImgeURL,
          Util.type,
        )
            .then((result) {
          Fluttertoast.showToast(
            msg: "Success!",
            toastLength: Toast.LENGTH_SHORT,
          );
        });
      else
        db
            .updateCompany(new Company(Util.uid, _companytName,
                _companyDescription, _companyImgeURL, Util.type))
            .then((result) {
          Fluttertoast.showToast(
            msg: "Success!",
            toastLength: Toast.LENGTH_SHORT,
          );
        });
      if (Util.type == Util.supplier)
        NavigationRouter.switchToSupplier(context);
      else
        NavigationRouter.switchToBuyer(context);
    }
  }

  Future<String> _uploadFile() async {
    final String rand1 = "${new Random().nextInt(10000)}";
    final String rand2 = "${new Random().nextInt(10000)}";
    final String rand3 = "${new Random().nextInt(10000)}";
    final StorageReference ref = FirebaseStorage.instance
        .ref()
        .child(Util.uid)
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
