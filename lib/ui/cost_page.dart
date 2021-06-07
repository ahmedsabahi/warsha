import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/ui/models/service.dart';
import 'package:warsha_app/ui/order_state_page.dart';
import 'package:warsha_app/ui/providers/service_provider.dart';
import 'package:warsha_app/widgets/Drawer_widget.dart';
import 'package:warsha_app/widgets/custom_button.dart';
import 'package:warsha_app/widgets/home_header.dart';
import 'package:warsha_app/widgets/maps.dart';
import 'package:warsha_app/widgets/services_list_view.dart';

class CostPage extends StatelessWidget {
  final TextEditingController _problemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var servicesList = Provider.of<List<Service>>(context);
    var servicesProvider = Provider.of<ServicesProvider>(context);

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
              'أطلب الان ورشة',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff022C43),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 350,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 90,
                color: Colors.white,
                child: servicesList == []
                    ? CircularProgressIndicator()
                    : ServicesListView(),
              ),
              Container(
                height: 260,
                color: Color(0xff022C43),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${servicesProvider.sum}  ريال',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.amberAccent,
                            ),
                          ),
                          Text(
                            'تكلفية الخدمة :  ',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'الاسعار شامل القيمة المضافة 15%',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _problemController,
                        textAlign: TextAlign.right,
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'سجل نوع العطل الذي تواجهه',
                          hintStyle: TextStyle(
                            color: Color(0xffB7BEC6),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          title: 'أطلب الان',
                          borderColor: Colors.transparent,
                          backgroundColor: Colors.amberAccent,
                          onPressed: () {
                            servicesProvider
                                .addProblem(_problemController.text);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OrderStatePage()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   width: double.infinity,
            //   height: 200,
            //   child: Maps(),
            // ),
          ],
        ),
      ),
    );
  }
}
