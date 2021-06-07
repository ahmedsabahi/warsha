import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/ui/profile/data.dart';
import 'package:warsha_app/ui/profile/display_account_page.dart';
import 'package:warsha_app/widgets/Text_Input_Decoration.dart';

class ProfilePage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final Map data = {
    'name': String,
    'email': String,
    'phone': int,
    'city': String,
    'street': String
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amberAccent,
        iconTheme: IconThemeData(color: Color(0xff022C43)),
        title: Text(
          'معلومات شخصية',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xff022C43),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autofocus: false,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.name,
                  onSaved: (input) => data['name'] = input,
                  style: TextStyle(color: Colors.black45),
                  decoration:
                      textInputDecoration.copyWith(hintText: 'الاسم كامل'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autofocus: false,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (input) => data['email'] = input,
                  style: TextStyle(color: Colors.black45),
                  decoration: textInputDecoration.copyWith(hintText: 'الإيميل'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autofocus: false,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.phone,
                  onSaved: (input) => data['phone'] = input,
                  style: TextStyle(color: Colors.black45),
                  decoration:
                      textInputDecoration.copyWith(hintText: 'رقم الجوال'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autofocus: false,
                  textAlign: TextAlign.right,
                  onSaved: (input) => data['city'] = input,
                  style: TextStyle(color: Colors.black45),
                  decoration: textInputDecoration.copyWith(hintText: 'المدينة'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autofocus: false,
                  textAlign: TextAlign.right,
                  onSaved: (input) => data['street'] = input,
                  style: TextStyle(color: Colors.black45),
                  decoration: textInputDecoration.copyWith(hintText: 'الحي'),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 53.0,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amberAccent),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () {
                        formKey.currentState.save();
                        Provider.of<Data>(context, listen: false)
                            .updateAccount(data);
                        formKey.currentState.reset();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AccountPage()));
                      },
                      child: Text(
                        'حفظ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
