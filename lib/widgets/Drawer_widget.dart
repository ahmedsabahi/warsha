import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/ui/account/login_screen.dart';
import 'package:warsha_app/utils/authentication.dart';
import 'package:warsha_app/widgets/loading.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Authentication>(context);

    return SafeArea(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(authProvider.user.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.hasData && !snapshot.data.exists) {
                  return Text("email does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();
                  return Text(data['email']);
                }

                return Loading();
              },
            ),
            accountName: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(authProvider.user.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError && snapshot.error) {
                  return Text("Something went wrong");
                }

                if (snapshot.hasData && !snapshot.data.exists) {
                  return Text("Name does not exist");
                }

                if (snapshot.hasData) {
                  Map<String, dynamic> data = snapshot.data.data();
                  return Text(data['name']);
                } else {
                  return Loading();
                }
              },
            ),
            currentAccountPicture: authProvider.user?.photoURL == null
                ? ClipOval(
                    child: Material(
                      color: Colors.amber,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.yellow,
                      ),
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(
                      authProvider.user.photoURL,
                    ),
                    radius: 70,
                  ),
            decoration: BoxDecoration(
              color: Color(0xff022C43),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.amberAccent,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () async {
              await authProvider.signOut(context: context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }
}
