import 'package:app_medicine/data_fake/schedule_patient.dart';
import 'package:app_medicine/model/filter_status.dart';
import 'package:app_medicine/model/patients.dart';
import 'package:app_medicine/screens/AppointmentBookingScreen.dart';
import 'package:app_medicine/styles/colors.dart';
import 'package:app_medicine/styles/styles.dart';
import 'package:flutter/material.dart'; // Import danh sách schedules

class ScheduleTab extends StatefulWidget {
  final String statusSchedule;

  const ScheduleTab({Key? key, required this.statusSchedule}) : super(key: key);

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

// Không cần định nghĩa lại FilterStatus và FilterStatusExtension ở đây nữa

class _ScheduleTabState extends State<ScheduleTab> {
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;
  String? _selectedDate;
  List<Patients> patients = [];

  final List<String> _dates = [
    'Tất cả',
    'Thứ 2, 13 tháng 5',
    'Thứ 3, 14 tháng 5',
    'Thứ 4, 15 tháng 5',
    'Thứ 5, 16 tháng 5',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.statusSchedule == 'Lịch hẹn') {
      status = FilterStatus.Complete;
      _alignment = Alignment.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map> filteredSchedules = schedule_patient.where((var patients) {
      return patients['status'] == status &&
          (_selectedDate == null || _selectedDate == 'Tất cả' || patients['reservedDate'] == _selectedDate);
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Lịch khám',
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
                                } else if (filterStatus == FilterStatus.Schedule) {
                                  status = FilterStatus.Schedule;
                                  _alignment = Alignment.center;
                                } else if (filterStatus == FilterStatus.Complete) {
                                  status = FilterStatus.Complete;
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
              value: _selectedDate,
              hint: Text('Chọn ngày khám'),
              isExpanded: true,
              items: _dates.map((String date) {
                return DropdownMenuItem<String>(
                  value: date,
                  child: Text(date),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDate = newValue;
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
                      ? 'Hủy Lịch hẹn'
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
                                    _schedule['patientName'],
                                    style: TextStyle(
                                      color: Color(MyColors.header01),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Bệnh nhân',
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
                                    Navigator.pushNamed(context, '/patientDetail', arguments: filteredSchedules[index]);
                                  },
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: ElevatedButton(
                                  child: Text(textButton),
                                  onPressed: () {
                                    if (status == FilterStatus.Complete) {
                                      _showCancelConfirmationDialog(context, _schedule);
                                    } else if (status == FilterStatus.Complete) {
                                      _deleteSchedule(_schedule);
                                    } else {
                                      _showCancelConfirmationDialog(context, _schedule);
                                    }
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

  void _showCancelConfirmationDialog(BuildContext context, Map schedule) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận hủy bỏ'),
          content: Text('Bạn có chắc chắn muốn hủy bỏ lịch hẹn này không?'),
          actions: [
            TextButton(
              child: Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Có'),
              onPressed: () {
                setState(() {
                  schedule['status'] = FilterStatus.Complete;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCancelScheduleConfirmationDialog(BuildContext context, Map schedule) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận hủy bỏ'),
          content: Text('Bạn có chắc chắn muốn hủy bỏ lịch hẹn này không?'),
          actions: [
            TextButton(
              child: Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Có'),
              onPressed: () {
                setState(() {
                  schedule['status'] = FilterStatus.Complete;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteSchedule(Map schedule) {
    setState(() {
      schedule_patient.remove(schedule);
    });
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
