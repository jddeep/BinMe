import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rrr/screens/MapPage.dart';
import 'package:rrr/screens/homePage.dart';
import 'package:rrr/screens/profilePage.dart';

class MainPage extends StatefulWidget {
  final int selIndex;
  final FirebaseUser user;
  MainPage({@required this.selIndex, @required this.user});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = widget.selIndex;
  }

  @override
  Widget build(BuildContext context) {
    final _pages = [
      HomePage(user: widget.user,),
      MapPage(),
      ProfilePage(user: widget.user),
    ];

    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text("Map"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}
