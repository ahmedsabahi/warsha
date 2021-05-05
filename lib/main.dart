import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:warsha_app/ui/login_page.dart';
import 'package:warsha_app/ui/verify_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}
