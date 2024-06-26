import 'package:app_medicine/enum/app_enum.dart';
import 'package:app_medicine/screens/doctor/doctor_schedule_screen.dart';
import 'package:app_medicine/tabs/Report/ReportDoctor.dart';
import 'package:app_medicine/tabs/SettingTab.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.calendar_today, 'index': 0},
  {'icon': Icons.report, 'index': 1},
  {'icon': Icons.account_balance, 'index': 2},
];

class _HomeState extends State<DoctorHome> {
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

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      DoctorScheduleScreen(scheduleDoctorStatus: ScheduleDoctorStatus.COMING),
      ReportDoctor(),
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
        selectedItemColor: Color(MyColors.primary),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // unselectedItemColor: Color(MyColors.grey01),
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
