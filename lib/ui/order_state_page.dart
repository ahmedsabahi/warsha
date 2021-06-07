import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warsha_app/ui/creditCardPage/credit_card_page.dart';
import 'package:warsha_app/ui/account/login_screen.dart';
import 'package:warsha_app/ui/bottom_navbar.dart';
import 'package:warsha_app/ui/providers/service_provider.dart';
import 'package:warsha_app/ui/summary_page.dart';
import 'package:warsha_app/utils/authentication.dart';
import 'package:warsha_app/widgets/Drawer_widget.dart';
import 'package:warsha_app/widgets/custom_button.dart';
import 'package:warsha_app/widgets/home_header.dart';
import 'package:warsha_app/widgets/maps.dart';

class OrderStatePage extends StatelessWidget {
  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: Offset(-1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.slowMiddle));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var servicesProvider = Provider.of<ServicesProvider>(context);
    var authProvider = Provider.of<Authentication>(context);

    return Scaffold(
      endDrawer: Drawer(
        child: DrawerWidget(),
      ),
      appBar: AppBar(
        elevation: 15,
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        iconTheme: IconThemeData(color: Color(0xff022C43)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Spacer(
              flex: 1,
            ),
            Text(
              'حالة الطلب',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff022C43),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.27,
            color: Colors.white70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.engineering,
                            size: 30,
                            color: Colors.black,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.amberAccent,
                              ),
                              Text(
                                ' 4.2',
                                style: TextStyle(
                                  color: Color(0xff313450),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'مقدم الخدمة',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff313450),
                              ),
                            ),
                            Text(
                              'فيصل',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff898A8F),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 50.0,
                        height: 50.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(50.0),
                            child: Image.asset(
                              'assets/images/technician.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          border: new Border.all(
                            color: Colors.amberAccent,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 70.0),
                      child: Text(
                        '${servicesProvider.sum} ريال',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff313450),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: Color(0xffECECEC)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => launch("tel://+201000457010"),
                      child: Column(
                        children: [
                          Icon(
                            Icons.call_outlined,
                            size: 30,
                            semanticLabel: 'call',
                            color: Colors.amberAccent,
                          ),
                          Text(
                            'اتصال',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff898A8F),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => launch("https://easacc.com"),
                      child: Column(
                        children: [
                          Icon(
                            Icons.share_outlined,
                            semanticLabel: 'share',
                            size: 30,
                            color: Colors.amberAccent,
                          ),
                          Text(
                            'سوشيال ميديا',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff898A8F),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => launch("sms://+201000457010"),
                      child: Column(
                        children: [
                          Icon(
                            Icons.sms_outlined,
                            semanticLabel: 'share',
                            size: 30,
                            color: Colors.amberAccent,
                          ),
                          Text(
                            'رسالة',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff898A8F),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => launch("tel://+201000457010"),
                      child: Column(
                        children: [
                          Icon(
                            Icons.more_vert_outlined,
                            semanticLabel: 'share',
                            size: 30,
                            color: Colors.amberAccent,
                          ),
                          Text(
                            'المزيد',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff898A8F),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 100,
            color: Color(0xff022C43),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  title: 'إلغاء الطلب',
                  borderColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BottomNavBar()));
                  },
                ),
                CustomButton(
                  title: 'الدفع',
                  borderColor: Colors.transparent,
                  backgroundColor: Colors.amberAccent,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "طرق الدفع",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "اختر طريقتك في الدفع",
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                color: Colors.black12,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: Text(
                                        'الدفع نقداً',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xff022C43),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SummaryPage()));
                                        // Navigator.of(context).pop();
                                      },
                                    ),
                                    SizedBox(width: 15.0),
                                    // CircleCheckbox(
                                    //   value: false,
                                    //   onChanged: null,
                                    // ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text(
                                      'دفع عبر مدى',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xff022C43),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  SizedBox(width: 15.0),
                                  // CircleCheckbox(
                                  //   value: false,
                                  //   onChanged: null,
                                  // ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text(
                                      'دفع عبر فيزا / ماستركارد',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xff022C43),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreditCardPage()));
                                      // Navigator.of(context).pop();
                                    },
                                  ),
                                  SizedBox(width: 15.0),
                                  // CircleCheckbox(
                                  //   value: true,
                                  //   onChanged: null,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Stack
        child: Column(
          children: [
            // Maps(),
          ],
        ),
      ),
    );
  }
}
