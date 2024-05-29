import 'package:app_medicine/screens/AppointmentBookingScreen.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

class ScheduleTab extends StatefulWidget {
  final String statusSchedule;

  const ScheduleTab({Key? key, required this.statusSchedule}) : super(key: key);

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

enum FilterStatus { Upcoming, Complete, Cancel }

extension FilterStatusExtension on FilterStatus {
  String get name {
    switch (this) {
      case FilterStatus.Upcoming:
        return 'Sắp tới';
      case FilterStatus.Complete:
        return 'Hoàn thành';
      case FilterStatus.Cancel:
        return 'Hủy bỏ';
      default:
        return "";
    }
  }
}

List<Map> schedules = [
  {
    'img': 'lib/assets/doctor2.png',
    'doctorName': 'Mai Thanh Nam',
    'doctorTitle': 'Bác sĩ tim mạch',
    'reservedDate': 'Thứ 3, 14 tháng 5',
    'reservedTime': '08:00 - 11:00',
    'status': FilterStatus.Upcoming,
    'department': 'Khoa Nội',
  },
  {
    'img': 'lib/assets/doctor2.png',
    'doctorName': 'Nguyễn Lê Lâm',
    'doctorTitle': 'Bác sĩ thần kinh',
    'reservedDate': 'Thứ 2, 13/5',
    'reservedTime': '07:00 - 09:00',
    'status': FilterStatus.Complete,
    'department': 'Khoa Thần Kinh',
  },
  {
    'img': 'lib/assets/doctor2.png',
    'doctorName': 'Đinh Văn Tuấn Hải',
    'doctorTitle': 'Bác sĩ ngoại khoa',
    'reservedDate': 'Thứ 2, 13/5',
    'reservedTime': '11:00 - 14:00',
    'status': FilterStatus.Upcoming,
    'department': 'Khoa Ngoại',
  },
  {
    'img': 'lib/assets/doctor2.png',
    'doctorName': 'Thạch Xuân Hoàng',
    'doctorTitle': 'Bác sĩ nha khoa',
    'reservedDate': 'Thứ 4, 15 tháng 5',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming,
    'department': 'Khoa Nha Khoa',
  },
  {
    'img': 'lib/assets/doctor2.png',
    'doctorName': 'Hồ Huy',
    'doctorTitle': 'Bác sĩ da liễu',
    'reservedDate': 'Thứ 2, 13/5',
    'reservedTime': '13:00 - 17:00',
    'status': FilterStatus.Cancel,
    'department': 'Khoa Da Liễu',
  },
  {
    'img': 'lib/assets/doctor2.png',
    'doctorName': 'Nguyễn Đào Anh Tuấn',
    'doctorTitle': 'Bác sĩ răng hàm mặt',
    'reservedDate': 'Thứ 4, 15 tháng 5',
    'reservedTime': '13:00 - 17:00',
    'status': FilterStatus.Upcoming,
    'department': 'Khoa Răng Hàm Mặt',
  },
];

class _ScheduleTabState extends State<ScheduleTab> {
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;
  String? _selectedDepartment;

  final List<String> _departments = [
    'Tất cả',
    'Khoa Nội',
    'Khoa Thần Kinh',
    'Khoa Ngoại',
    'Khoa Nha Khoa',
    'Khoa Da Liễu',
    'Khoa Răng Hàm Mặt',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.statusSchedule == 'Hoàn thành') {
      status = FilterStatus.Complete;
      _alignment = Alignment.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map> filteredSchedules = schedules.where((var schedule) {
      return schedule['status'] == status &&
          (_selectedDepartment == null || _selectedDepartment == 'Tất cả' || schedule['department'] == _selectedDepartment);
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Đặt lịch bác sĩ',
              textAlign: TextAlign.center,
              style: kTitleStyle,
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(MyColors.bg),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.Upcoming) {
                                  status = FilterStatus.Upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus == FilterStatus.Complete) {
                                  status = FilterStatus.Complete;
                                  _alignment = Alignment.center;
                                } else if (filterStatus == FilterStatus.Cancel) {
                                  status = FilterStatus.Cancel;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                filterStatus.name,
                                style: kFilterStyle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedDepartment,
              hint: Text('Chọn Khoa'),
              isExpanded: true,
              items: _departments.map((String department) {
                return DropdownMenuItem<String>(
                  value: department,
                  child: Text(department),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDepartment = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  var _schedule = filteredSchedules[index];
                  bool isLastElement = filteredSchedules.length + 1 == index;
                  var textButton = filteredSchedules[index]['status'] == FilterStatus.Upcoming
                      ? 'Đặt lịch'
                      : filteredSchedules[index]['status'] == FilterStatus.Complete
                      ? 'Hủy bỏ'
                      : 'Xóa';
                  return Card(
                    margin: !isLastElement ? EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(_schedule['img']),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _schedule['doctorName'],
                                    style: TextStyle(
                                      color: Color(MyColors.header01),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    _schedule['doctorTitle'],
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          DateTimeCard(
                            reservedDate: _schedule['reservedDate'],
                            reservedTime: _schedule['reservedTime'],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  child: Text('Chi tiết'),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/detail', arguments: filteredSchedules[index]);
                                  },
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: ElevatedButton(
                                  child: Text(textButton),
                                  onPressed: () {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AppointmentBookingScreen(),
                                      ),
                                    );
                                  // Navigator.pushNamed(context, '/AppointmentBooking', arguments: filteredSchedules[index]);
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  final String reservedDate;
  final String reservedTime;

  const DateTimeCard({
    Key? key,
    required this.reservedDate,
    required this.reservedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              SizedBox(width: 5),
              Text(
                reservedDate,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
              SizedBox(width: 3),
              Text(
                reservedTime,
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
