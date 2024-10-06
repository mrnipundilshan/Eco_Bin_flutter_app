import 'package:flutter/material.dart';
import 'package:pro2/user/article.dart';
import 'package:pro2/user/calender.dart';
import 'package:pro2/user/homepage.dart';
import 'package:pro2/user/location.dart';

class navpage extends StatefulWidget {
  final String email;
  final String username;

  navpage({super.key, required this.email, required this.username});

  @override
  State<navpage> createState() => _navpageState();
}

class _navpageState extends State<navpage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _pages = <Widget>[
    homepage(
      email: widget.email,
      username: widget.username,
      onItemTapped: _onItemTapped,
    ),
    calender(),
    location(),
    article(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: const Color.fromARGB(255, 31, 160, 143),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              size: size.width * 0.07,
              Icons.home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              size: size.width * 0.07,
              Icons.calendar_month,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              size: size.width * 0.07,
              Icons.location_on_outlined,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              size: size.width * 0.07,
              Icons.wb_incandescent_sharp,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    ));
  }
}
