import 'package:app_medicine/dialog/user_book_submit_dialog.dart';
import 'package:app_medicine/enum/app_enum.dart';
import 'package:app_medicine/model/department.dart';
import 'package:app_medicine/model/doctor_appointment.dart';
import 'package:app_medicine/screens/user/doctor_appointment_done.dart';
import 'package:app_medicine/service/department_service.dart';
import 'package:app_medicine/service/doctor_appointment_service.dart';
import 'package:app_medicine/widgets/time_slot_tags.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/appointment.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';

class DoctorScheduleScreen extends StatefulWidget {
  final ScheduleDoctorStatus scheduleDoctorStatus;

  const DoctorScheduleScreen({super.key, required this.scheduleDoctorStatus});

  @override
  State<DoctorScheduleScreen> createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
  final doctorAppointmentService = DoctorAppointmentService();

  bool loadData = false;

  ScheduleDoctorStatus _status = ScheduleDoctorStatus.COMING;
  Alignment _alignment = Alignment.centerLeft;

  List<Department> _departments = [];

  DateTime? _selectedDate;
  late List<DateTime> _dates;

  late List<DoctorAppointment> _listDoctorAppointment = [];

  @override
  void initState() {
    super.initState();
    _getNextThreeWeekdays();
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 20),
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
                      for (ScheduleDoctorStatus scheduleDoctorStatus in ScheduleDoctorStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (scheduleDoctorStatus == ScheduleDoctorStatus.COMING) {
                                  _status = ScheduleDoctorStatus.COMING;
                                  _alignment = Alignment.centerLeft;
                                } else if (scheduleDoctorStatus == ScheduleDoctorStatus.DONE) {
                                  _status = ScheduleDoctorStatus.DONE;
                                  _alignment = Alignment.center;
                                } else if (scheduleDoctorStatus == ScheduleDoctorStatus.CANCLE) {
                                  _status = ScheduleDoctorStatus.CANCLE;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                scheduleDoctorStatus.name,
                                style: kFilterStyle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: 110,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        _status.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            if (_status == ScheduleDoctorStatus.COMING) ...[
              DropdownButton<DateTime>(
                value: _selectedDate,
                hint: const Text('Chọn ngày'),
                isExpanded: true,
                items: _dates.map((DateTime date) {
                  return DropdownMenuItem<DateTime>(
                    value: date,
                    child: Text(DateFormat('dd/MM/yyyy').format(date)), // Format the date as you want
                  );
                }).toList(),
                onChanged: (DateTime? newValue) {
                  setState(() {
                    _selectedDate = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<DoctorAppointment>>(
                  future: _getDoctorAppointmentSignUp(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data found'));
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _listDoctorAppointment.length,
                        itemBuilder: (context, index) {
                          var doctorAppointment = _listDoctorAppointment[index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage: AssetImage('lib/assets/doctor2.png'),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doctorAppointment.name,
                                            style: TextStyle(
                                              color: Color(MyColors.header01),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            doctorAppointment.degree,
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
                                  const SizedBox(height: 15),
                                  TimeSlotTags(appointments: doctorAppointment.appointments,
                                      onTimeSlotSelected: (appointment) {
                                        if (appointment.status == DoctorAppointmentStatus.AVAILABLE) {
                                          showSubmitDialog(context, appointment, doctorAppointment);
                                        }
                                      }
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ] else if (_status == ScheduleUserStatus.DONE) ...[
              DoctorAppointmentDoneTab(),
            ] else if (_status == ScheduleUserStatus.HISTORY) ...[
            ],

          ],
        ),
      ),
    );
  }

  void showSubmitDialog(BuildContext context, Appointment appointment, DoctorAppointment doctorAppointment) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return UserBookSubmitDialog(
          appointment: appointment, doctorAppointment: doctorAppointment,
          onSuccess: (appointmentId) {
            setState(() {
              _status = ScheduleDoctorStatus.DONE;
              _alignment = Alignment.center;
            });
          }
        );
      },
    );
  }

  List<DateTime> _getNextThreeWeekdays() {
    List<DateTime> dates = [];
    DateTime now = DateTime.now();

    while (dates.length < 3) {
      if (now.weekday < 6) { // 6 and 7 represents Saturday and Sunday
        dates.add(now);
      }
      now = now.add(const Duration(days: 1));
    }

    _dates = dates;
    _selectedDate = _dates[0]; // Set the selected date to today
    return _dates;
  }

  Future<List<DoctorAppointment>> _getDoctorAppointmentSignUp() async {
    // _listDoctorAppointment = await doctorAppointmentService.getDoctorAppointmentSignUp(_selectedDate, {});
    return _listDoctorAppointment;
  }

}
