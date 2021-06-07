import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/ui/bottom_navbar.dart';
import 'package:warsha_app/ui/providers/location_provider.dart';
import 'package:warsha_app/ui/providers/service_provider.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/date_symbol_data_local.dart';

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var servicesProvider = Provider.of<ServicesProvider>(context);
    var locationProvider = Provider.of<LocationProvider>(context);

    initializeDateFormatting();
    DateTime now = DateTime.now();
    String formattedTime = intl.DateFormat.Hms().format(now);

    String formattedDate = intl.DateFormat.yMMMMEEEEd("ar_sa").format(now);

    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        iconTheme: IconThemeData(color: Color(0xff022C43)),
        leading: IconButton(
            icon: Icon(Icons.close_outlined),
            // onPressed: () => Navigator.of(context).pop(),

            onPressed: () {
              servicesProvider.dateTimeLocation(
                  time: formattedTime,
                  date: formattedDate,
                  location: locationProvider.currentAddress);
              servicesProvider.addOrder();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomNavBar()),
                (Route<dynamic> route) => false,
              );
              servicesProvider.reset();
            }),
        title: Text(
          'الطلب',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff022C43),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formattedTime,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.timer,
                      size: 20.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formattedDate,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.today_outlined,
                      size: 20.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'فيصل',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      ':مقدم الخدمة ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      Icons.engineering,
                      size: 20.0,
                    ),
                  ],
                ),
                Text(
                  ' ${locationProvider.currentAddress}',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "القيمة",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "الخدمة",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 20.0,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: servicesProvider.favList.length,
                  itemBuilder: (context, index) {
                    var service = servicesProvider.favList[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${service.price.toString()} ريال',
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          '${service.name}',
                        ),
                      ],
                    );
                  },
                ),
                Divider(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${servicesProvider.sum}  ريال',
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      'إجمالي السعر',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '15% [ ${servicesProvider.tax} ريال ] ',
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      'الضريبة',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${servicesProvider.sumPlusTax}  ريال',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'إجمالي السعر بعد الضريبة',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
