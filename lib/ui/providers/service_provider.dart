import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/service.dart';
import '../services/fireStore_service.dart';

class ServicesProvider with ChangeNotifier {
  final service = FireStoreService();
  final fireStoreInstance = FirebaseFirestore.instance.collection("Users");
  User firebaseUser = FirebaseAuth.instance.currentUser;

  static String _id;
  static String _image;
  static bool _isFavourite;
  static String _name;
  static double _price;
  static List<Service> _favList = [];
  static List<num> priceList = [];
  static List<String> serviceList = [];
  static var _sum;
  static String _problem;
  static double _tax;
  static double _sumPlusTax;
  static String _time;
  static String _date;
  static String _location;

//Getters:
  String get id => _id;
  String get name => _name;
  String get image => _image;
  bool get favourite => _isFavourite;
  num get price => _price;
  String get problems => _problem;
  num get tax => _tax;
  num get sumPlusTax => _sumPlusTax;
  num get sum => _sum;
  List<Service> get favList => _favList;

//Setters:
  void addOrder() {
    fireStoreInstance.doc(firebaseUser.uid).collection('Orders').doc().set({
      'date': _date,
      'time': _time,
      'serviceList': FieldValue.arrayUnion(serviceList),
      'priceList': FieldValue.arrayUnion(priceList),
      'location': _location,
      "sum": _sum,
      "tax": _tax,
      "sumPlusTax": _sumPlusTax,
    });
  }

  void dateTimeLocation({String time, String date, String location}) {
    _time = time;
    _date = date;
    _location = location;
    notifyListeners();
  }

  void reset() {
    favList.clear();
    priceList.clear();
    serviceList.clear();
    _date = null;
    _time = null;
    _sum = 0;
    _tax = 0;
    _sumPlusTax = 0;
    _location = null;
    _problem = null;
  }

  void addProblem(String problem) {
    _problem = problem;
    notifyListeners();
  }

  void setTax() {
    _tax = (sum * 15) / 100;
    notifyListeners();
  }

  void setSumPlusTax() {
    _sumPlusTax = sum + _tax;
    notifyListeners();
  }

  void changeIsFavourite(String id, bool fav) {
    service.updateServices(id, fav);
  }

  void addToList(Object ser, num price, String serviceName) {
    favList.add(ser);
    priceList.add(price);
    serviceList.add(serviceName);
    _sum = priceList.reduce((a, b) => a + b);
    setTax();
    setSumPlusTax();
    notifyListeners();
    print('---------------------$favList');
    print('---------------------$priceList');
  }

  void removeFromList(Object ser, num price, String serviceName) {
    favList.remove(ser);
    priceList.remove(price);
    serviceList.remove(serviceName);

    if (priceList.isNotEmpty) {
      _sum = priceList.reduce((a, b) => a + b);
    } else {
      _sum = 0;
    }
    setTax();
    setSumPlusTax();
    notifyListeners();
  }

  void removeData() {
    service.deleteService(_id);
    notifyListeners();
  }
}
