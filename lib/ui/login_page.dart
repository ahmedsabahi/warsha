import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:warsha_app/ui/verify_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth get auth => FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
  String verificationId;

  Future<void> verifyPhoneNumber() async {
    await auth.verifyPhoneNumber(
        phoneNumber: '+20' + _phoneNumberController.text,

        // codeSent: (String verId, [int forceCodeResend]) {
        //   this.verificationId = verId;
        //   smsCodeDialog(context).then((value) {
        //     print('Signed in');
        //   });
        // },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          this.verificationId = verificationId;

          // // Update the UI - wait for the user to enter the SMS code
          // String smsCode = 'xxxx';
          //
          // // Create a PhoneAuthCredential with the code
          // PhoneAuthCredential credential = PhoneAuthProvider.credential(
          //     verificationId: verificationId, smsCode: smsCode);
          //
          // // Sign the user in (or link) with the credential
          // await auth.signInWithCredential(credential);
        },
        verificationCompleted: (PhoneAuthCredential credential) {
          // Sign the user in (or link) with the auto-generated credential
          auth.signInWithCredential(credential).then((value) {
            if (value.user != null) {
              print('-----------------Authentication successful');
            } else {
              print('------------------Invalid code/invalid authentication');
            }
          }).catchError((error) {
            print('----------------Something has gone wrong, please try later');
          });
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
          print('--------Auto retrieval time out');
        },
        verificationFailed: (exception) {
          print('${exception.message}');
          if (exception.message.contains('not authorized'))
            print('--------Something has gone wrong, please try later');
          else if (exception.message.contains('Network'))
            print(
                '--------Please check your internet connection and try again');
          else
            print('---------Something has gone wrong, please try later');
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 60.0, right: 50.0, bottom: 30.0),
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
                  height: 400.0,
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: Container(
                            width: 250,
                            child: Text(
                              'تسجيل الدخول',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 15.0, left: 15.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: TextFormField(
                                  enabled: false,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  initialValue: "+20",
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 5.0, 5.0, 5.0),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/SA-Flag-icon.png"),
                                        height: 20.0,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: TextField(
                                  controller: _phoneNumberController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: 'رقم الجوال',
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  maxLength: 10,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w300),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Container(
                                  width: 245.0,
                                  height: 50.0,
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xffFFD700)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      verifyPhoneNumber();

                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            VerifyPage(id: verificationId),
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'التالي',
                                        style: TextStyle(
                                            color: Colors.white,
                                            backgroundColor: Color(0xffFFD700),
                                            fontSize: 24),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff022C43)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                  image:
                                      AssetImage("assets/images/instagram.png"),
                                  height: 25.0,
                                ),
                              ),
                            ),
                            OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff022C43)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                  image: AssetImage("assets/images/google.png"),
                                  height: 25.0,
                                ),
                              ),
                            ),
                            OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff022C43)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                  image:
                                      AssetImage("assets/images/facebook.png"),
                                  height: 25.0,
                                ),
                              ),
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
        ],
      ),
    );
  }
}
