// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'homepage.dart';
//
// void main() => runApp(new MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//         home: new MyHomePage(),
//         routes: <String, WidgetBuilder>{
//           '/homepage': (BuildContext context) => DashboardPage(),
//           '/landingpage': (BuildContext context) => MyHomePage()
//         });
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String phoneNo;
//   String smsCode;
//   String verificationId;
//
//   Future<void> verifyPhone() async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     await auth.verifyPhoneNumber(
//         phoneNumber: this.phoneNo,
//         timeout: const Duration(seconds: 60),
//         codeAutoRetrievalTimeout: (String verificationId) {
//           this.verificationId = verificationId;
//         },
//         // codeSent: (String verId, [int forceCodeResend]) {
//         //   this.verificationId = verId;
//         //   smsCodeDialog(context).then((value) {
//         //     print('Signed in');
//         //   });
//         // },
//         codeSent: (String verificationId, int resendToken) async {
//           this.verificationId = verificationId;
//
//           // Update the UI - wait for the user to enter the SMS code
//           String smsCode = 'xxxx';
//
//           // Create a PhoneAuthCredential with the code
//           PhoneAuthCredential credential = PhoneAuthProvider.credential(
//               verificationId: verificationId, smsCode: smsCode);
//
//           // Sign the user in (or link) with the credential
//           await auth.signInWithCredential(credential);
//           signIn() {
//             FirebaseAuth.instance
//                 .signInWithPhoneNumber(
//                     verificationId: verificationId, smsCode: smsCode)
//                 .then((user) {
//               Navigator.of(context).pushReplacementNamed('/homepage');
//             }).catchError((e) {
//               print(e);
//             });
//           }
//         },
//         verificationCompleted: (user) {
//           print('verified');
//         },
//         verificationFailed: (exception) {
//           print('${exception.message}');
//         });
//   }
//
//   Future<bool> smsCodeDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return new AlertDialog(
//             title: Text('Enter sms Code'),
//             content: TextField(
//               onChanged: (value) {
//                 this.smsCode = value;
//               },
//             ),
//             contentPadding: EdgeInsets.all(10.0),
//             actions: <Widget>[
//               new FlatButton(
//                 child: Text('Done'),
//                 onPressed: () {
//                   FirebaseAuth.instance
//                     ..currentUser.then((user) {
//                       if (user != null) {
//                         Navigator.of(context).pop();
//                         Navigator.of(context).pushReplacementNamed('/homepage');
//                       } else {
//                         Navigator.of(context).pop();
//                         signIn();
//                       }
//                     });
//                 },
//               )
//             ],
//           );
//         });
//   }
//
//   signIn() {
//     FirebaseAuth.instance
//         .signInWithPhoneNumber(verificationId: verificationId, smsCode: smsCode)
//         .then((user) {
//       Navigator.of(context).pushReplacementNamed('/homepage');
//     }).catchError((e) {
//       print(e);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('PhoneAuth'),
//       ),
//       body: new Center(
//         child: Container(
//             padding: EdgeInsets.all(25.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Phone number'),
//                   onChanged: (value) {
//                     this.phoneNo = value;
//                   },
//                 ),
//                 SizedBox(height: 10.0),
//                 RaisedButton(
//                     onPressed: verifyPhone,
//                     child: Text('Verify'),
//                     textColor: Colors.white,
//                     elevation: 7.0,
//                     color: Colors.blue)
//               ],
//             )),
//       ),
//     );
//   }
// }
