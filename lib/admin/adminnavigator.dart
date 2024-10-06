import 'package:flutter/material.dart';
import 'package:pro2/admin/adminarticle.dart';
import 'package:pro2/admin/admincalender.dart';
import 'package:pro2/admin/adminhome.dart';
import 'package:pro2/admin/adminlocation.dart';

class adminnavpage extends StatefulWidget {
  final String email;
  final String username;

  adminnavpage({super.key, required this.email, required this.username});

  @override
  State<adminnavpage> createState() => _adminnavpageState();
}

class _adminnavpageState extends State<adminnavpage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _pages = <Widget>[
    adminhome(
        email: widget.email,
        username: widget.username,
        onItemTapped: _onItemTapped),
    admincalender(),
    adminlocation(),
    adminarticle()
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
              Icons.home,
              size: size.width * 0.07,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
              size: size.width * 0.07,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on_outlined,
              size: size.width * 0.07,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.wb_incandescent_sharp,
              size: size.width * 0.07,
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
