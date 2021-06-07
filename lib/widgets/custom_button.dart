import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Function onPressed;
  final Color borderColor;

  const CustomButton({
    @required this.title,
    @required this.backgroundColor,
    @required this.onPressed,
    @required this.borderColor,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 50.0,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          side: BorderSide(
            width: 1,
            color: borderColor,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
