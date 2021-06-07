import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({Key key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  // GoogleMapController _controller;
  // Marker marker;
  // Position currentPosition;
  //
  // static final CameraPosition _myLocation = CameraPosition(
  //   target: LatLng(20.5937, 78.9629),
  //   bearing: 15.0,
  //   tilt: 75.0,
  // );
  //
  // void _onMapCreated(GoogleMapController _cntlr) {
  //   _controller = _cntlr;
  //   Geolocator.getPositionStream().listen((Position position) {
  //     _controller.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //             target: LatLng(position.latitude, position.longitude), zoom: 15),
  //       ),
  //     );
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Text('hi');
  }

  // GoogleMap(
  // initialCameraPosition: _myLocation,
  // mapType: MapType.normal,
  // onMapCreated: _onMapCreated,
  // )

  // _getCurrentLocation() async {
  //   LocationPermission permission = await Geolocator.requestPermission();
  //
  //   Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     setState(() {
  //       currentPosition = position;
  //     });
  //     print('${position.latitude},${position.longitude}');
  //   }).catchError((e) {
  //     print('--++--$e');
  //   });
  // }
}
