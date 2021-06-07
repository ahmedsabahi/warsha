import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/ui/account/login_screen.dart';
import 'package:warsha_app/ui/bottom_navbar.dart';
import 'package:warsha_app/ui/creditCardPage/credit_card_provider.dart';
import 'package:warsha_app/ui/models/order.dart';
import 'package:warsha_app/ui/models/service.dart';
import 'package:warsha_app/ui/providers/location_provider.dart';
import 'package:warsha_app/ui/providers/service_provider.dart';
import 'package:warsha_app/utils/authentication.dart';
import '../ui/services/fireStore_service.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final fireStoreService = FireStoreService();
  @override
  Widget build(BuildContext context) {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    Widget firstWidget;
    if (firebaseUser != null) {
      firstWidget = BottomNavBar();
    } else {
      firstWidget = LoginScreen();
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication(firebaseUser)),
        ChangeNotifierProvider.value(value: ServicesProvider()),
        ChangeNotifierProvider.value(value: CreditCardProvider()),
        ChangeNotifierProvider.value(value: LocationProvider(context)),
        StreamProvider<List<Service>>(
            create: (_) => fireStoreService.getServices(), initialData: []),
        StreamProvider<List<Order>>(
            create: (_) => fireStoreService.getOrders(), initialData: []),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Nahdi'),
        home: Scaffold(
          body: firstWidget,
        ),
      ),
    );
  }
}
