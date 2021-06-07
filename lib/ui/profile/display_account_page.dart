import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/ui/profile/data.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amberAccent,
        iconTheme: IconThemeData(color: Color(0xff022C43)),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'معلومات شخصية',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 22,
              color: Color(0xff022C43),
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Text('Name: ' + Provider.of<Data>(context).data['name'].toString()),
          Text('Email: ' + Provider.of<Data>(context).data['email'].toString()),
          Text('Phone: ' + Provider.of<Data>(context).data['phone'].toString()),
          Text('City: ' + Provider.of<Data>(context).data['city'].toString()),
          Text('Street: ' +
              Provider.of<Data>(context).data['street'].toString()),
        ]),
      ),
    );
  }
}
