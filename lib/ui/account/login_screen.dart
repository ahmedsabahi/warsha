import 'dart:io' show Platform;

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/utils/authentication.dart';
import 'package:warsha_app/ui/bottom_navbar.dart';
import 'package:warsha_app/ui/account/register_screen.dart';
import 'package:warsha_app/ui/account/signin_email_screen.dart';
import 'package:warsha_app/ui/account/verify_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _countryCode = "+966";
  final TextEditingController _phoneNumberController = TextEditingController();
  void _onCountryChange(CountryCode countryCode) {
    this._countryCode = countryCode.toString();
  }

  // Navigates to a new page
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  void _pushReplacementPage(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Authentication>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, right: 50.0, bottom: 20.0),
                    child: Image.asset('assets/images/LoginLogo.png'),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/LoginBG.png",
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Container(
                      height: 380.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  CountryCodePicker(
                                    onChanged: _onCountryChange,
                                    initialSelection: '+966',
                                    favorite: ['+966', '+20'],
                                    dialogSize: Size.fromHeight(300.0),
                                    hideSearch: true,
                                    alignLeft: true,
                                    showDropDownButton: true,
                                    showCountryOnly: false,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                    child: TextFormField(
                                      maxLength: 10,
                                      controller: _phoneNumberController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.phone,
                                      style: TextStyle(color: Colors.black45),
                                      decoration: InputDecoration(
                                        hintText: 'رقم الجوال',
                                        counter: Offstage(),
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 15.0),
                                    child: Container(
                                      width: 245.0,
                                      height: 50.0,
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.amberAccent),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await authProvider.verifyPhoneNumber(
                                              context: context,
                                              countryCode: _countryCode,
                                              phone:
                                                  _phoneNumberController.text);

                                          _pushPage(
                                              context,
                                              VerifyScreen(
                                                num:
                                                    _phoneNumberController.text,
                                                code: _countryCode,
                                              ));
                                        },
                                        child: Text(
                                          'التالي',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: InkWell(
                                      child: Text(
                                        'تسجيل الدخول من خلال الإيميل',
                                        style: TextStyle(
                                            color: Color(0xff022C43),
                                            fontSize: 14.0),
                                      ),
                                      onTap: () => _pushPage(
                                          context, SignInEmailScreen()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SignInButton(
                                  Buttons.Facebook,
                                  mini: true,
                                  elevation: 2.0,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  onPressed: () async {
                                    User user = await authProvider
                                        .signInWithFacebook(context: context);
                                    if (user != null) {
                                      _pushReplacementPage(
                                          context, BottomNavBar());
                                    }
                                  },
                                ),
                                (Platform.isIOS)
                                    // (Platform.isAndroid)
                                    ? SignInButton(
                                        Buttons.Apple,
                                        mini: true,
                                        elevation: 2.0,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 3),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        onPressed: () async {
                                          // User user = await Authentication
                                          //     .signInWithApple(context: context);
                                          // if (user != null) {
                                          //   _pushReplacementPage(
                                          //       context, BottomNavBar());
                                          // }
                                        },
                                      )
                                    : SizedBox(),
                                SignInButtonBuilder(
                                  text: '',
                                  mini: true,
                                  elevation: 3.0,
                                  image: Image(
                                    image:
                                        AssetImage("assets/images/google.jpg"),
                                    height: 20,
                                  ),
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  onPressed: () async {
                                    User user = await authProvider
                                        .signInWithGoogle(context: context);
                                    if (user != null) {
                                      _pushReplacementPage(
                                          context, BottomNavBar());
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: 245.0,
                  height: 50.0,
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 1.5,
                        color: Color(0xff022C43),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    onPressed: () => _pushPage(context, RegisterScreen()),
                    child: Text(
                      'انشاء حساب',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff022C43), fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
