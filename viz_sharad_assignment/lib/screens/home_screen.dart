import 'package:flutter/material.dart';
import 'package:viz_sharad_assignment/screens/profile_screen.dart';

import 'employee_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static int _selectedIndex = 0;
  late List<Widget> _pages ;
  late Widget _employeesScreen;
  late Widget _profileScreen;

  @override
  void initState() {
    // TODO: implement initState
    _employeesScreen = const EmployeeScreen();
    _profileScreen = const ProfileScreen();
    _pages = [_employeesScreen,_profileScreen];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // key: navBarKey,
        backgroundColor: Colors.grey[200],
        elevation: 15,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black26,
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            // icon: Image.asset(
            //   'assets/images/new_home_icon.png',
            //   width: 20,
            //   height: 20,
            //   // fit: BoxFit.scaleDown,
            // ),
            label: 'Employee',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
      // body: IndexedStack(
      //   index: _selectedIndex,
      //   children: _pages,
      // )
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }

  void _onItemTapped(int index) {

    if(mounted == true){
      setState(() {
        _selectedIndex = index;
      });
    }
  }

}

