import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/ui/models/service.dart';
import 'package:warsha_app/ui/notification/notify_page.dart';
import 'package:warsha_app/ui/providers/location_provider.dart';
import 'package:warsha_app/widgets/Drawer_widget.dart';
import 'package:warsha_app/widgets/home_header.dart';
import 'package:warsha_app/widgets/loading.dart';
import 'package:warsha_app/widgets/services_grid_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var servicesList = Provider.of<List<Service>>(context);
    var locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      endDrawer: Drawer(
        child: DrawerWidget(),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160.0), // here the desired height
        child: AppBar(
          elevation: 15,
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
          iconTheme: IconThemeData(color: Color(0xff022C43)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(60),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Spacer(
                  flex: 2,
                ),
                Text(
                  'ورشة',
                  style: TextStyle(
                    fontFamily: 'Nahdi',
                    fontSize: 39,
                  ),
                ),
              ],
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NotifyPage()));
            },
            child: Icon(
              Icons.notifications_none_outlined,
              size: 26.0,
            ),
          ),
          bottom: PreferredSize(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, bottom: 5.0, right: 20.0),
                    child: TextField(
                      autofocus: false,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'بحث سريع عن الخدمة',
                        hintStyle: TextStyle(color: Colors.black26),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, right: 25, left: 30, top: 10),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                          text: '',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' موقعك الحالي',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    locationProvider.getCurrentLocation(
                                        context: context);
                                    print('The button is clicked!');
                                  }),
                            locationProvider.currentAddress != null
                                ? TextSpan(
                                    text: ' ${locationProvider.currentAddress}')
                                : TextSpan(text: ''),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              preferredSize: Size.fromHeight(50.0)),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            HomeHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 15.0, 20.0, 8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    'خدمات',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            servicesList == [] ? Loading() : ServicesGridView(),
          ],
        ),
      ),
    );
  }
}
