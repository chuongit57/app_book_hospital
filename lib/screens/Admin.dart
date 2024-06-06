import 'package:app_medicine/model/user.dart';
import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../tabs/AdminTab/AdminTab.dart';
import '../tabs/AdminTab/SettingTab.dart';


class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.admin_panel_settings, 'index': 0},
  {'icon': Icons.account_balance, 'index': 1},
];


class _AdminState extends State<Admin> {
  int _selectedIndex = 0;
  String statusSchedule = '';

  get user => null;
  void goToSchedule() {
    setState(() {
      _selectedIndex = 1;
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      AdminDoctorScreen(),
      SettingTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(MyColors.primary),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        // selectedItemColor: Color(MyColors.primary),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          for (var navigationBarItem in navigationBarItems)
            BottomNavigationBarItem(
              icon: Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border(
                    top: _selectedIndex == navigationBarItem['index']
                        ? BorderSide(color: Color(MyColors.bg01), width: 5)
                        : BorderSide.none,
                  ),
                ),
                child: Icon(
                  navigationBarItem['icon'],
                ),
              ),
              label: '',
            ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() {
          _selectedIndex = value;
        }),
      ),
    );
  }
}
