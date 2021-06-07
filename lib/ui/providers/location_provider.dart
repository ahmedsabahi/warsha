import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position _currentPosition;
  String _currentAddress;

  String get currentAddress => _currentAddress;
  Position get currentPosition => _currentPosition;

  LocationProvider(context) {
    getCurrentLocation(context: context);
  }

  Future<void> getCurrentLocation({@required BuildContext context}) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Can't get current location"),
              content:
                  const Text('Please make sure you enable GPS and try again'),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    final AndroidIntent intent = AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                    intent.launch();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permission permanently denied')));
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Permission denied')));
      }
    }
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      _currentPosition = position;
      getAddressFromLatLng();

      print('${_currentPosition.latitude},${_currentPosition.altitude}');
    }).catchError((e) {
      print('Get Current Location Error : $e');
    });
    notifyListeners();
  }

  Future<void> getAddressFromLatLng() async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude,
          localeIdentifier: "ar_sa");

      Placemark place = placeMarks[0];

      _currentAddress = "${place.street}";

      print('$_currentAddress');
      // _currentAddress = " ${place.country},${place.street},${place.locality}";
    } catch (e) {
      print('Get Address From Lat Lng Error : $e');
    }
    notifyListeners();
  }
}
