import 'package:app_medicine/enum/app_enum.dart';
import 'package:app_medicine/model/department.dart';
import 'package:app_medicine/model/doctor_appointment.dart';
import 'package:app_medicine/service/department_service.dart';
import 'package:app_medicine/service/doctor_appointmen_service.dart';
import 'package:app_medicine/service/user_book_service.dart';
import 'package:app_medicine/widgets/time_slot_tags.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/appointment.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';

class ScheduleTab extends StatefulWidget {
  final ScheduleUserStatus scheduleUserStatus;

  const ScheduleTab({super.key, required this.scheduleUserStatus});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  final doctorAppointmentService = DoctorAppointmentService();
  final departmentService = DepartmentService();

  ScheduleUserStatus status = ScheduleUserStatus.SIGN_UP;
  Alignment _alignment = Alignment.centerLeft;
  String? _selectedDepartment;
  DateTime? _selectedDate;
  late List<DateTime> _dates;

  late List<DoctorAppointment> _listDoctorAppointment = [];
  late List<Department> _departments = [];

  Future<List<Department>> getListDepartment() async {
    _departments = await departmentService.getSelectDepartments();
    return _departments;
  }

  Future<List<DoctorAppointment>> getDoctorAppointmentSignUp() async {
    _listDoctorAppointment = await doctorAppointmentService.getDoctorAppointmentSignUp(_selectedDate, _selectedDepartment);
    return _listDoctorAppointment;
  }

  List<DateTime> getNextThreeWeekdays() {
    List<DateTime> dates = [];
    DateTime now = DateTime.now();

    while (dates.length < 3) {
      if (now.weekday < 6) { // 6 and 7 represents Saturday and Sunday
        dates.add(now);
      }
      now = now.add(Duration(days: 1));
    }

    _dates = dates;
    return _dates;
  }

  void _showInputPopup(
      Appointment appointment,
      DoctorAppointment doctorAppointment,
      DateTime _selectedDate,
      BuildContext context) {
    // Khởi tạo TextEditingController
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final ageController = TextEditingController();
    final weightController = TextEditingController();
    final userBookService = UserBookService();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        var title = "";

        title = DateFormat('dd/MM/yyyy').format(_selectedDate) + " - " + appointment.startTime + " - " + appointment.endTime;

        return AlertDialog(
          title: Text('Đang đặt lịch với bác sĩ :  $title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Tên',
                  ),
                  keyboardType: TextInputType.name,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                  ),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: 'Tuổi',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: weightController,
                  decoration: InputDecoration(
                    labelText: 'Cân nặng',
                  ),
                  keyboardType: TextInputType.number,
                )
              ],
            ),
          ),
            actions: <Widget>[
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  bool _isLoading = false;

                  return _isLoading
                      ? CircularProgressIndicator()
                      : TextButton(
                    child: Text('Đặt lịch'),
                    onPressed: () async {
                      // Lấy giá trị từ TextEditingController
                      String name = nameController.text;
                      String phone = phoneController.text;
                      int age = int.parse(ageController.text);
                      double weight = double.parse(weightController.text);

                      // Call the API to book the appointment
                      // If the API call is successful, close the dialog
                      // If the API call is not successful, show an error message
                      Map<String, dynamic> body = {
                        'name': name,
                        'phone': phone,
                        'age': age,
                        'weight': weight,
                      };

                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        await userBookService.book(appointment.id, body);
                        Navigator.of(context).pop();
                      } catch (e) {
                        // Handle error
                      } finally {
                        if (_isLoading) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
                  );
                },
              ),
            ]
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getListDepartment().then((departments) {
      setState(() {
        _departments = departments;
      });
    });
    getNextThreeWeekdays();
    _selectedDate = _dates[0]; // Set the selected date to today
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
                      for (ScheduleUserStatus scheduleUserStatus in ScheduleUserStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (scheduleUserStatus == ScheduleUserStatus.SIGN_UP) {
                                  status = ScheduleUserStatus.SIGN_UP;
                                  _alignment = Alignment.centerLeft;
                                } else if (scheduleUserStatus == ScheduleUserStatus.HISTORY) {
                                  status = ScheduleUserStatus.HISTORY;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                scheduleUserStatus.name,
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
                    width: 170,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
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
            DropdownButton<String>(
              value: _selectedDepartment,
              hint: const Text('Chọn Khoa'),
              isExpanded: true,
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text('Tất cả các khoa'),
                ),
                ..._departments.map((Department department) {
                  return DropdownMenuItem<String>(
                    value: department.code,
                    child: Text(department.name),
                  );
                }),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDepartment = newValue;
                });
              },
            ),
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
                future: getDoctorAppointmentSignUp(),
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
                                  onTimeSlotSelected: (slot) {
                                    if (slot.status == DoctorAppointmentStatus.AVAILABLE) {
                                      _showInputPopup(
                                          slot,
                                          doctorAppointment,
                                          _selectedDate!,
                                          context);
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
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận hủy bỏ'),
          content: const Text('Bạn có chắc chắn muốn hủy bỏ lịch hẹn này không?'),
          actions: [
            TextButton(
              child: const Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Có'),
              onPressed: () {
                setState(() {
                  // schedule['status'] = FilterStatus.Schedule;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _reviewSchedule() {
    setState(() {

    });
  }
}

class DateTimeCard extends StatelessWidget {
  final String reservedDate;
  final String reservedTime;

  const DateTimeCard({
    super.key,
    required this.reservedDate,
    required this.reservedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
              const SizedBox(width: 5),
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
              const SizedBox(width: 3),
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