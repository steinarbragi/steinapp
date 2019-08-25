import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './login_signup.dart';
import 'package:location/location.dart';



class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      //bearing: 192.8334901395799,
      target: LatLng(-14.391183,65.258885),
      //tilt: 29.440717697143555,
      zoom: 19.151926040649414);

  void login() {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginSignUp()),
  );
  }

  void getCurrentLocation() {
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Map'),
        actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                login();
              },
            ),
      ]),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the bar!'),
        icon: Icon(Icons.local_bar),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}