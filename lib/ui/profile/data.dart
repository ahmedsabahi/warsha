import 'package:flutter/material.dart';

class Data extends ChangeNotifier {
  Map data = {};

  void updateAccount(input) {
    data = input;
    notifyListeners();
  }
}
