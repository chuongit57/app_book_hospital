import 'package:app_medicine/model/user.dart';
import 'package:app_medicine/tabs/SettingTab.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../tabs/HomeTab.dart';
import '../tabs/ScheduleTab.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.local_hospital, 'index': 0},
  {'icon': Icons.calendar_today, 'index': 1},
  {'icon': Icons.account_balance, 'index': 2},
];

// final List<Users> defaultUsers = [
//   Users(usrName: "admin", usrPassword: "111111"),
//   Users(usrName: "doctor", usrPassword: "111111"),
//   Users(usrName: "chuong", usrPassword: "111111"),
//   Users(usrName: "aaaaaa", usrPassword: "111111"),
// ];

class _AdminState extends State<Admin> {
  int _selectedIndex = 0;
  String statusSchedule = '';
  void goToSchedule() {
    setState(() {
      _selectedIndex = 1;
    });
    setState(() {
      statusSchedule = 'Lịch hẹn';
    });
  }


  // Future<bool> getData() async {
  //   await Future.delayed(Duration(seconds: 5));
  //   for user in userAo {
  //     user.username == usertext {
  //       if ===
  //
  //       return true;
  //   }
  //   retrun false
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeTab(
        onPressedScheduleCard: goToSchedule,
      ),
      ScheduleTab(statusSchedule: statusSchedule),
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
                  // color: _selectedIndex == 0
                  //     ? Color(MyColors.bg01)
                  //     : Color(MyColors.bg02),
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
