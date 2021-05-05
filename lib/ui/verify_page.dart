import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:warsha_app/ui/home_page.dart';

class VerifyPage extends StatefulWidget {
  final String id;

  VerifyPage({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  TextEditingController _textEditingController = TextEditingController();
  String currentText = "";

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void signInWithPhoneNumber(String smsCode) async {
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.id, smsCode: smsCode);

      // // Sign the user in (or link) with the credential
      (await FirebaseAuth.instance.signInWithCredential(credential)).user;

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    } catch (e) {
      print("Error:------ $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      padding: const EdgeInsets.only(bottom: 25.0, top: 80.0),
                      child: Container(
                        width: 250,
                        child: Text(
                          'رسالة التحقيق',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 40),
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
                                'الرجاء إدخال التحقق المكون من 4 أرقام تم إرسال الرمز إلى رقم هاتفك الخلوي 310555 5555 عبر الرسائل القصيرة أو قم بتغيير رقمك.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: PinCodeTextField(
                        length: 6,
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
                        controller: _textEditingController,
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
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
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
                          onPressed: () {
                            signInWithPhoneNumber(_textEditingController.text);
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
