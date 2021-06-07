import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class Authentication with ChangeNotifier {
  User user;
  String _verifyId;
  bool isLoading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  final fireStoreInstance = FirebaseFirestore.instance.collection("Users");

  Authentication(firebaseUser) {
    user = firebaseUser;
  }

  String get verifyId => _verifyId;
  User get users => user;

  void changeIsLoading(bool x) {
    isLoading = x;
  }
  //  Future<FirebaseApp> initializeFirebase({
  //   @required BuildContext context,
  // }) async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp();
  //
  //   User user = auth.currentUser;
  //
  //   if (user != null) {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => BottomNavBar(),
  //       ),
  //     );
  //   }
  //
  //   return firebaseApp;
  // }

  Future<User> registrationWithEmailAndPassword(
      {@required BuildContext context,
      @required String username,
      @required String email,
      @required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      fireStoreInstance.doc(user.uid).set({
        "email": email,
        "name": username,
      });

      isLoading = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to sign in with Email & Password. $e')));
      print(e);
    }
    notifyListeners();

    return user;
  }

  Future<User> signInWithEmailAndPassword(
      {@required BuildContext context,
      @required String email,
      @required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to sign in with Email & Password. $e')));
      print(e);
    }
    notifyListeners();

    return user;
  }

  Future<void> sendPasswordResetEmail(
      {@required BuildContext context, @required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Email is not valid')));
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No user found.')));
      }
    }
  }

  Future<void> verifyPhoneNumber(
      {@required BuildContext context,
      @required String phone,
      @required String countryCode}) async {
    String phoneNumber = phone.toString().trim();

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) {};

    PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) {
      print(
          'Phone number verification failed. Code: ${e.code}. Message: ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Phone number verification failed. Code: ${e.code}. Message: ${e.message}')));
    };

    // PhoneCodeSent codeSent =
    //     (String verificationId, [int forceResendingToken]) async {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text('Please check your phone for the verification code.')));
    //   _verifyId = verificationId;
    //   notifyListeners();
    //   print('Code Sent');
    // };

    // PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
    //     (String verificationId) {
    //   _verifyId = verificationId;
    //   print('SMS Auto Retrieval Timeout');
    //   notifyListeners();
    // };

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: countryCode + phoneNumber,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: (String verificationId, [int forceResendingToken]) async {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text('Please check your phone for the verification code.')));
          _verifyId = verificationId;
          print('Code Sent');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verifyId = verificationId;
          print('SMS Auto Retrieval Timeout');
        },
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<User> submitOTP(
      {@required BuildContext context, @required String sms}) async {
    User user;

    // get the `smsCode` from the user
    String smsCode = sms.toString().trim();

    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verifyId,
        smsCode: smsCode,
      );

      // Sign the user in (or link) with the credential
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      user = userCredential.user;
      fireStoreInstance.doc(user.uid).set({
        "email": user.email,
        "name": user.displayName,
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign in with phone number $e')));
      print('Failed to sign in $e');
    }
    notifyListeners();

    return user;
  }

  Future<User> signInWithGoogle({@required BuildContext context}) async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        fireStoreInstance.doc(user.uid).set({
          "email": user.email,
          "name": user.displayName,
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'The account already exists with a different credential')));
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Error occurred while accessing credentials. Try again.')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text('Error Code:${e.code}, Error Message: ${e.message}')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Error occurred using Google Sign In. Try again. $e')));
      }
    }
    notifyListeners();

    return user;
  }

  Future<User> signInWithFacebook({@required BuildContext context}) async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result != null) {
      // Create a credential from the access token
      final AuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken.token);
      try {
        // Once signed in, return the UserCredential
        final UserCredential userCredential =
            await auth.signInWithCredential(facebookAuthCredential);

        user = userCredential.user;
        fireStoreInstance.doc(user.uid).set({
          "email": user.email,
          "name": user.displayName,
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'The account already exists with a different credential')));
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Error occurred while accessing credentials. Try again.')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text('Error Code:${e.code}, Error Message: ${e.message}')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to sign in with Facebook: $e')));
      }
    }
    notifyListeners();

    return user;
  }

  Future<void> signOut({@required BuildContext context}) async {
    try {
      await auth.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing out. Try again. $e')));
    }
  }
}
