import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/ui/bottom_navbar.dart';
import 'package:warsha_app/utils/authentication.dart';

class VerifyScreen extends StatefulWidget {
  final String num;
  final String code;

  VerifyScreen({
    Key key,
    @required this.num,
    @required this.code,
  }) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool hasError = false;
  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Authentication>(context);

    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Image.asset('assets/images/LoginLogo.png'),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/verify-bg.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 60.0),
                      child: Container(
                        width: 250,
                        child: Text(
                          'رسالة التحقيق',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Container(
                        height: 125.0,
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
                          padding: const EdgeInsets.only(right: 50, left: 50),
                          child: Center(
                            child: Container(
                              width: 250,
                              child: Text(
                                'الرجاء إدخال التحقق المكون من 6 أرقام تم إرسال الرمز إلى رقم هاتفك الخلوي ${widget.code + widget.num} عبر الرسائل القصيرة أو قم بتغيير رقمك.',
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 30.0, left: 30.0, top: 30.0),
                      child: PinCodeTextField(
                        length: 6,
                        enablePinAutofill: true,
                        obscureText: false,
                        appContext: context,
                        keyboardType: TextInputType.number,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        pinTheme: PinTheme(
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 40,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          activeColor: Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        animationType: AnimationType.fade,
                        enableActiveFill: true,
                        controller: _otpController,
                        cursorColor: Colors.black,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                    ),
                    Text(
                      hasError ? "*Please fill up all the cells properly" : '',
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
                      child: Container(
                        width: 70.0,
                        height: 70.0,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff022C43)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (_otpController.text.length != 6) {
                              setState(() {
                                hasError = true;
                              });
                            } else {
                              setState(() {
                                hasError = false;
                              });
                              User user = await authProvider.submitOTP(
                                  context: context, sms: _otpController.text);

                              if (user != null) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomNavBar()),
                                    (route) => false);
                              }
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
