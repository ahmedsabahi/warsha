import 'package:flutter/material.dart';

class NotifyPage extends StatefulWidget {
  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amberAccent,
        iconTheme: IconThemeData(color: Color(0xff022C43)),
        actions: [
          new IconButton(
            icon: new Icon(Icons.arrow_forward_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
        title: Row(
          children: [
            Spacer(
              flex: 1,
            ),
            Text(
              'الاشعارات',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xff022C43),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '05:52 AM',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff8f8f97),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'تحديث',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff313450),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'برجاء تحديث التطبيق إلي اخر اصدار',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff838489),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFF5E7C9),
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(50.0),
                      child: Icon(
                        Icons.notifications,
                        semanticLabel: 'call',
                        size: 30,
                        color: Colors.amberAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
