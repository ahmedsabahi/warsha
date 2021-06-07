import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/ui/models/order.dart';
import 'package:warsha_app/widgets/loading.dart';

class MyOrdersPage extends StatelessWidget {
  MyOrdersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ordersList = Provider.of<List<Order>>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amberAccent,
        iconTheme: IconThemeData(color: Color(0xff022C43)),
        title: Text(
          'الطلبات',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xff022C43),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: ordersList == []
              ? Loading()
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: ordersList.length,
                  itemBuilder: (context, index) {
                    var order = ordersList[index];
                    return Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 2.5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13.0, vertical: 13.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: [
                            Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                Icon(
                                  Icons.today_outlined,
                                  size: 20.0,
                                ),
                                Text(order.date.toString()),
                                Spacer(
                                  flex: 1,
                                ),
                                Icon(
                                  Icons.timer,
                                  size: 20.0,
                                ),
                                Text(order.time.toString()),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Wrap(
                              textDirection: TextDirection.rtl,
                              alignment: WrapAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 20.0,
                                ),
                                Text(
                                  order.location.toString(),
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                Text(
                                  'مقدم الخدمة:',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text('فيصل'),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'إجمالي السعر',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  '${order.sum.toString()} ريال',
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'الضريبة',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  '${order.tax.toString()} ريال',
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'إجمالي السعر بعد الضريبة',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  '${order.sumPlusTax.toString()} ريال',
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Wrap(
                              spacing: 5.0,
                              alignment: WrapAlignment.end,
                              children: order.serviceList
                                  .map(
                                    (e) => Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 3.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.amberAccent,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 7.0),
                                        child: Text(e),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
