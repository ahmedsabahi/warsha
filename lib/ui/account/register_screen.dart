import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/utils/authentication.dart';
import 'package:warsha_app/ui/bottom_navbar.dart';
import 'package:warsha_app/ui/account/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:warsha_app/widgets/loading.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _passwordVisible;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Navigates to a new page
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  // String validatePassword(String value) {
  //   // r'^
  //   //   (?=.*[A-Z])       // should contain at least one upper case
  //   //   (?=.*[a-z])       // should contain at least one lower case
  //   //   (?=.*?[0-9])      // should contain at least one digit
  //   //   (?=.*?[!@#\$&*~]) // should contain at least one Special character
  //   //     .{8,}             // Must be at least 8 characters in length
  //   // $
  //
  //   Pattern pattern =
  //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  //   RegExp regex = new RegExp(pattern);
  //   print(value);
  //   if (value.isEmpty) {
  //     return 'Please enter password';
  //   } else {
  //     if (!regex.hasMatch(value))
  //       return 'Enter valid password';
  //     else
  //       return null;
  //   }
  // }

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                            Container(
                              width: 250,
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                'تسجيل',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15.0, left: 15.0),
                              child: Column(
                                children: [
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: _userNameController,
                                          textAlign: TextAlign.center,
                                          autocorrect: false,
                                          keyboardType: TextInputType.name,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter a valid username';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'username',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 35.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                          ),
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        TextFormField(
                                          controller: _emailController,
                                          textAlign: TextAlign.center,
                                          autocorrect: false,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (value) => EmailValidator
                                                  .validate(value)
                                              ? null
                                              : "Please enter a valid email",
                                          decoration: InputDecoration(
                                            hintText: 'Email',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 35.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                          ),
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        TextFormField(
                                          controller: _passwordController,
                                          textAlign: TextAlign.center,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: _passwordVisible,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a valid password';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Password',
                                            contentPadding:
                                                EdgeInsets.only(left: 35.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _passwordVisible
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
                                                color: Theme.of(context)
                                                    .shadowColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                            ),
                                          ),
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  authProvider.isLoading
                                      ? Loading()
                                      : Container(
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
                                              if (_formKey.currentState
                                                  .validate()) {
                                                authProvider
                                                    .changeIsLoading(true);
                                                User user = await authProvider
                                                    .registrationWithEmailAndPassword(
                                                        context: context,
                                                        email: _emailController
                                                            .text,
                                                        password:
                                                            _passwordController
                                                                .text,
                                                        username:
                                                            _userNameController
                                                                .text);
                                                if (user != null) {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BottomNavBar()),
                                                  );
                                                }
                                              }
                                            },
                                            child: Text(
                                              'تسجيل',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
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
                    onPressed: () => _pushPage(context, LoginScreen()),
                    child: Text(
                      'تسجيل الدخول',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff022C43),
                        fontSize: 18,
                      ),
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
