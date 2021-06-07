import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.black26,
  ),
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
  floatingLabelBehavior: FloatingLabelBehavior.always,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
    borderRadius: BorderRadius.circular(10.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink),
    borderRadius: BorderRadius.circular(10.0),
  ),
);
