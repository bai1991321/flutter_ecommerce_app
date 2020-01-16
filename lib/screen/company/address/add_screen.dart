import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/services/firebase_shippo_service.dart';
import 'package:flutter_ecommerce/utils/form_validate.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../flutter-shippo/models/addresses/address.dart';
import '../../../flutter-shippo/models/addresses/create.dart';
import '../../../flutter-shippo/services/addresses/create.dart';
import '../../../flutter-shippo/services/addresses/validate.dart';

const kGoogleApiKey = "AIzaSyAbAChOvFMmjguB9kwGUbHmDBeOCLm7Hzs";
GoogleMapsPlaces _places = new GoogleMapsPlaces(apiKey: kGoogleApiKey);

class AddAddressScreen extends StatefulWidget {
  // static PlaceDetails placeDetails = null;

  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String name = '';
  String street = '';
  String apartment = '';
  String city = '';
  String state = '';
  String zipcode = '';
  bool isLoading = false;
  PlaceDetails pickedPlace;
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController streetCtrl = new TextEditingController();
  TextEditingController apartmentCtrl = new TextEditingController();
  TextEditingController cityCtrl = new TextEditingController();
  TextEditingController stateCtrl = new TextEditingController();
  TextEditingController zipcodeCtrl = new TextEditingController();
  GoogleMapController mapController;
  LocationManager.Location _location = new LocationManager.Location();
  Marker markerOptions =Marker(
    markerId: MarkerId("value"),
    position: LatLng(37.43296265331129, -122.08832357078792),
    infoWindow: InfoWindow(title: 'loading...')
  );

  bool _saving = false;

  void initState() {
    super.initState();
  }

  dynamic componentForm = ({
    'street_number': 'short_name',
    'route': 'long_name',
    'locality': 'long_name',
    'administrative_area_level_1': 'short_name',
    'country': 'long_name',
    'postal_code': 'short_name'
  });

  onClickFromMap() async {
    setState(() {
      if (pickedPlace != null) {
        for (var i = 0; i < pickedPlace.addressComponents.length; i++) {
          var addressType = pickedPlace.addressComponents[i].types[0];
          if (componentForm[addressType] != null) {
            setState(() {
              nameCtrl.text = pickedPlace.name;
              if (addressType == 'street_number')
                apartmentCtrl.text = pickedPlace.addressComponents[i].shortName;
              if (addressType == 'route')
                streetCtrl.text = pickedPlace.addressComponents[i].longName;
              if (addressType == 'locality')
                cityCtrl.text = pickedPlace.addressComponents[i].longName;
              if (addressType == 'administrative_area_level_1')
                stateCtrl.text = pickedPlace.addressComponents[i].shortName;
              if (addressType == 'postal_code')
                zipcodeCtrl.text = pickedPlace.addressComponents[i].shortName;
            });
          }
        }
      }
    });
  }

  void refresh() async {
    final center = await getUserLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
    // if (center != null)
    //   getNearbyPlaces(center);
  }

  Future<LatLng> getUserLocation() async {
    LocationManager.LocationData currentLocation;
    try {
      currentLocation = await _location.getLocation();
      final lat = currentLocation.latitude;
      final lng = currentLocation.longitude;
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh();
  }

  Future<void> _handlePressButton() async {
    try {
      Prediction p = await showGooglePlacesAutocomplete(
          context: context,
          apiKey: kGoogleApiKey,
          // onError: onError,
          mode: Mode.overlay,
          language: "en",
          components: [new Component(Component.country, "us")]);

      showDetailPlace(p.placeId);
    } catch (e) {
      return;
    }
  }

  Future<Null> showDetailPlace(String placeId) async {
    if (placeId != null) {
      PlacesDetailsResponse place = await _places.getDetailsByPlaceId(placeId);
      pickedPlace = place.result;
      onClickFromMap();
      LatLng val = LatLng(place.result.geometry.location.lat,
          place.result.geometry.location.lng);
      // getNearbyPlaces(val);
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: val == null ? LatLng(0, 0) : val, zoom: 15.0)));
      markerOptions = Marker(
          markerId: MarkerId(pickedPlace.placeId),
          position: val,
          infoWindow: InfoWindow(
              title: "${place.result.name}"+"${place.result.types?.first}"));
      // mapController.addMarker(markerOptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
        centerTitle: true,
        actions: <Widget>[
          isLoading
              ? IconButton(
                  icon: Icon(Icons.timer),
                  onPressed: () {},
                )
              : IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    refresh();
                  },
                ),
        ],
      ),
      body: ModalProgressHUD(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  child: SizedBox(
                      height: 200.0,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition:
                            CameraPosition(target: LatLng(0, 0)),
                        markers: Set<Marker>.of([markerOptions]),
                      ))),
              ListTile(
                title: new TextFormField(
                  controller: nameCtrl,
                  // initialValue: name,
                  maxLength: 40,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "First and Last Name of the address",
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: FormValidate().validateMustInput,
                  onSaved: (String value) {
                    name = value;
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                  ),
                  OutlineButton(
                    highlightedBorderColor: Colors.amber,
                    splashColor: Colors.amber,
                    disabledBorderColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Text("Search Address Through google map"),
                    onPressed: _handlePressButton,
                    padding: EdgeInsets.all(20),
                  ),
                  Expanded(
                    child: SizedBox(),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    'OR',
                    style: TextStyle(fontSize: 30),
                  ),
                  Expanded(
                    child: SizedBox(),
                  )
                ],
              ),
              ListTile(
                title: new TextFormField(
                  controller: streetCtrl,
                  // initialValue: street,
                  maxLength: 35,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Street Address",
                    prefixIcon: const Icon(Icons.view_stream),
                  ),
                  validator: FormValidate().validateMustInput,
                  onSaved: (String value) {
                    street = value;
                  },
                ),
              ),
              ListTile(
                title: new TextFormField(
                  controller: apartmentCtrl,
                  // initialValue: apartment,
                  maxLength: 35,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Apartment Number",
                    prefixIcon: const Icon(Icons.confirmation_number),
                  ),
                  onSaved: (String value) {
                    apartment = value;
                  },
                ),
              ),
              ListTile(
                title: new TextFormField(
                  controller: cityCtrl,
                  // initialValue: city,
                  maxLength: 35,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "City",
                    prefixIcon: const Icon(Icons.location_city),
                  ),
                  validator: FormValidate().validateMustInput,
                  onSaved: (String value) {
                    city = value;
                  },
                ),
              ),
              ListTile(
                title: new TextFormField(
                  controller: stateCtrl,
                  // initialValue: state,
                  maxLength: 2,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "State",
                    prefixIcon: const Icon(Icons.settings_input_antenna),
                  ),
                  validator: FormValidate().validateMustInput,
                  onSaved: (String value) {
                    state = value;
                  },
                ),
              ),
              ListTile(
                title: new TextFormField(
                  controller: zipcodeCtrl,
                  // initialValue: zipcode,
                  maxLength: 5,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Zip Code",
                    prefixIcon: const Icon(Icons.local_post_office),
                  ),
                  validator: FormValidate().validateMustInput,
                  onSaved: (String value) {
                    zipcode = value;
                  },
                ),
              ),
            ],
          ),
        ),
        inAsyncCall: _saving,
      ),
      bottomNavigationBar: new Container(
        height: 65,
        child: MaterialButton(
          color: Colors.deepOrange,
          onPressed: doCheckAndRegiste,
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "CHECK AND REGISTE",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
          // ),
        ),
      ),
    );
  }

  doCheckAndRegiste() async {
    setState(() {
      _saving = true;
    });
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AddressCreateBody addressbody = new AddressCreateBody(
        city: this.city,
        state: this.state,
        zip: this.zipcode,
        name: this.name,
        street1: "${this.apartment} ${this.street}",
        country: "US",
        company: Util.companyname,
        email: Util.emailId,
      );
      Address adress = await addressCreate(addressbody);
      Address result = await fetchAddressValidate(adress.object_id);
      if (result.validation_results.is_valid) {
        FirebaseShippoService db = new FirebaseShippoService();
        await db.createShippo(
            Util.uid, "addresses", result.object_id, result.toMap());
        Navigator.pop(context);
      } else {
        _showAskDialog(result.validation_results.messages[0].text,
            result.validation_results.messages[0].code);
      }
    }
    setState(() {
      _saving = false;
    });
  }

  void _showAskDialog(String message, String code) {
    // flutter defined function
    Alert(
        type: AlertType.error,
        context: context,
        title: code,
        content: Text(message),
        buttons: [
          new DialogButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ]).show();
  }
}
