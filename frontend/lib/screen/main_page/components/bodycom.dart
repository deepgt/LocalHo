import 'package:ecom_shop/screen/main_page/components/trending.dart';
import 'package:ecom_shop/screen/user_profile/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class BodyCom extends StatefulWidget {
  const BodyCom({key}) : super(key: key);

  @override
  _BodyComState createState() => _BodyComState();
}

class _BodyComState extends State<BodyCom> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Trending(),
    Home(),
    UserProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: 'Trending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
