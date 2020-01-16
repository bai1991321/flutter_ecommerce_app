import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as LocationManager;

const kGoogleApiKey = "AIzaSyAbAChOvFMmjguB9kwGUbHmDBeOCLm7Hzs";
GoogleMapsPlaces _places = new GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MapsScreen extends StatefulWidget {
  // double _latitude, _longitude;
  // MapsScreen(this._latitude, this._longitude);

  @override
  State createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  List<PlacesSearchResult> places = [];
  bool isLoading = false;
  String errorMessage;
  LocationManager.Location _location = new LocationManager.Location();

  // LocationManager.LocationData _startLocation;
  PlaceDetails pickedPlace;
  String error;

  bool currentWidget = true;

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  initPlatformState() async {
    LocationManager.LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      location = await _location.getLocation();

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _location = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget expandedChild;
    if (isLoading) {
      expandedChild = Center(child: CircularProgressIndicator(value: null));
    } else if (errorMessage != null) {
      expandedChild = Center(
        child: Text(errorMessage),
      );
    } else {
      expandedChild = buildPlacesList();
    }

    return Scaffold(
        key: homeScaffoldKey,
        appBar: AppBar(
          title: const Text("Address"),
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
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _handlePressButton();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
                child: SizedBox(
                    height: 200.0,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition:
                          CameraPosition(target: LatLng(0, 0)),
                    ))),
            Row(
              children: <Widget>[Text("Selected Places")],
            ),
            buildPickedPlaceWidget(),
            Row(
              children: <Widget>[Text("Near by Places")],
            ),
            Expanded(child: expandedChild)
          ],
        ));
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

  void refresh() async {
    final center = await getUserLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
    if (center != null) getNearbyPlaces(center);
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh();
  }

  void getNearbyPlaces(LatLng center) async {
    setState(() {
      this.isLoading = true;
      this.errorMessage = null;
    });
    final location = Location(center.latitude, center.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2500);

    setState(() {
      this.isLoading = false;
      if (result.status == "OK") {
        this.places = result.results;
        result.results.forEach((f) {
          final markerOptions = Marker(
              markerId: MarkerId(f.placeId),
              position:
                  LatLng(f.geometry.location.lat, f.geometry.location.lng),
              infoWindow: InfoWindow(title: "${f.name}" + "${f.types?.first}", snippet: '*'));
          // mapController(markerOptions);
        });
      } else {
        this.errorMessage = result.errorMessage;
      }
    });
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
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
      LatLng val = LatLng(place.result.geometry.location.lat,
          place.result.geometry.location.lng);
      getNearbyPlaces(val);
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: val == null ? LatLng(0, 0) : val, zoom: 15.0)));
      final markerOptions =  Marker(
              markerId: MarkerId(pickedPlace.placeId),
              position:
                  LatLng(pickedPlace.geometry.location.lat, pickedPlace.geometry.location.lng),
              infoWindow: InfoWindow(title: "${pickedPlace.name}" + "${pickedPlace.types?.first}", snippet: '*'));
      // mapController.addMarker(markerOptions);
    }
  }

  Widget buildPickedPlaceWidget() {
    if (pickedPlace != null) {
      List<Widget> list = [
        Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            pickedPlace.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
        )
      ];
      if (pickedPlace.formattedAddress != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            pickedPlace.formattedAddress,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ));
      }

      if (pickedPlace.vicinity != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            pickedPlace.vicinity,
            style: Theme.of(context).textTheme.body1,
          ),
        ));
      }

      if (pickedPlace.types?.first != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            pickedPlace.types.first,
            style: Theme.of(context).textTheme.caption,
          ),
        ));
      }

      return Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: Card(
          child: InkWell(
            onTap: () {
              doReturnWidthValue(pickedPlace);
            },
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list,
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: Card(
          child: InkWell(
            onTap: () {
              // onSelectedAddress(pickedPlace);
            },
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.red,
            child: Padding(
                padding: EdgeInsets.all(8.0), child: Text("Non Selected")),
          ),
        ),
      );
    }
  }

  ListView buildPlacesList() {
    final placesWidget = places.map((f) {
      List<Widget> list = [
        Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            f.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
        )
      ];
      if (f.formattedAddress != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.formattedAddress,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ));
      }

      if (f.vicinity != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.vicinity,
            style: Theme.of(context).textTheme.body1,
          ),
        ));
      }

      if (f.types?.first != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.types.first,
            style: Theme.of(context).textTheme.caption,
          ),
        ));
      }

      return Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: Card(
          child: InkWell(
            onTap: () {
              onSelectedAddress(f);
            },
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list,
              ),
            ),
          ),
        ),
      );
    }).toList();

    return ListView(shrinkWrap: true, children: placesWidget);
  }

  onSelectedAddress(PlacesSearchResult sResult) async {
    String address = sResult.formattedAddress;
    doReturnWidthValue(
        (await _places.getDetailsByPlaceId(sResult.placeId)).result);
  }

  doReturnWidthValue(PlaceDetails value) {
    // AddAddressScreen.placeDetails = value;
    Navigator.of(context).pop();
  }
}
