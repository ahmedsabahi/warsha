import 'package:flutter/material.dart';
import 'package:warsha_app/ui/home_screen.dart';
import 'package:warsha_app/ui/orderPage/my_orders_page.dart';
import 'package:warsha_app/ui/profile/profile_page.dart';
import 'package:warsha_app/widgets/maps.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> currentTab = [
    HomeScreen(),
    MyOrdersPage(),
    Maps(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentTab[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Color(0xff115173),
        iconSize: 25,
        unselectedFontSize: 12,
        selectedFontSize: 14,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'طلباتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'موقعك',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}
