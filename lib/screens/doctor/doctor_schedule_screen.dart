import 'package:app_medicine/dialog/user_book_submit_dialog.dart';
import 'package:app_medicine/enum/app_enum.dart';
import 'package:app_medicine/model/doctor_appointment.dart';
import 'package:app_medicine/model/doctor_appointment_upcoming_response.dart';
import 'package:app_medicine/screens/user/doctor_appointment_done.dart';
import 'package:app_medicine/service/user_book_service.dart';
import 'package:flutter/material.dart';
import '../../model/appointment.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';
import 'date_picker.dart';
import 'doctor_appointment_list.dart';

class DoctorScheduleScreen extends StatefulWidget {
  final ScheduleDoctorStatus scheduleDoctorStatus;

  const DoctorScheduleScreen({super.key, required this.scheduleDoctorStatus});

  @override
  State<DoctorScheduleScreen> createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
  final userBookService = UserBookService();
  bool loadData = false;
  ScheduleDoctorStatus _status = ScheduleDoctorStatus.COMING;
  Alignment _alignment = Alignment.centerLeft;

  DateTime? _selectedDate;
  late List<DateTime> _dates;
  late List<DoctorAppointmentUpcomingResponse> _listUserAppointmentUpcoming = [];

  void _reloadData() {
    setState(() {
      // Thực hiện việc tải lại dữ liệu ở đây
      loadData = true; // Ví dụ: Thay đổi trạng thái loadData để gây ra việc tải lại dữ liệu
    });
  }

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
              'Danh sách lịch hẹn',
              textAlign: TextAlign.center,
              style: kTitleStyle,
            ),
            const SizedBox(height: 20),
            _buildStatusToggle(),
            const SizedBox(height: 20),
            if (_status == ScheduleDoctorStatus.COMING) ...[
              DatePicker(
                dates: _dates,
                selectedDate: _selectedDate,
                onDateChanged: (newValue) {
                  setState(() {
                    _selectedDate = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: DoctorAppointmentList(
                  futureAppointments: _getListUserAppointmentUpcoming(),
                  // Truyền callback vào DoctorAppointmentList
                  onLoad: _reloadData,
                ),
              ),
            ] else if (_status == ScheduleDoctorStatus.DONE) ...[
              const DoctorAppointmentDoneTab(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusToggle() {
    return Stack(
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

  Future<List<DoctorAppointmentUpcomingResponse>> _getListUserAppointmentUpcoming() async {
    _listUserAppointmentUpcoming = await userBookService.getListUserAppointmentUpcoming(_selectedDate);
    return _listUserAppointmentUpcoming;
  }

}
