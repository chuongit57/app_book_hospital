import 'package:flutter/material.dart';

import '../../model/doctor_appointment_done_response.dart';
import '../../service/doctor_appointment_service.dart';
import '../../service/user_book_service.dart';
import '../../styles/colors.dart';
import '../../utils/date_utils.dart';
import '../../utils/toast_utils.dart';

class DoctorAppointmentDoneTab extends StatefulWidget {
  const DoctorAppointmentDoneTab({super.key});

  @override
  State<DoctorAppointmentDoneTab> createState() => _DoctorAppointmentDoneTabState();
}

class _DoctorAppointmentDoneTabState extends State<DoctorAppointmentDoneTab> {
  final DoctorAppointmentService doctorAppointmentService = DoctorAppointmentService();
  late List<DoctorAppointmentDoneResponse> _lstDoctorAppointmentDone = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(child:
        Stack(
          children: [
            Expanded(
              child: FutureBuilder<List<DoctorAppointmentDoneResponse>>(
                future: _fetchLstDoctorAppointmentDone(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return AppointmentInfoCard(
                          doctorAppointmentDone: snapshot.data![index],
                          onDelete: _handleDelete,
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        )
    );
  }

  Future<List<DoctorAppointmentDoneResponse>> _fetchLstDoctorAppointmentDone() async {
    _lstDoctorAppointmentDone = await doctorAppointmentService.getListDoctorAppointmentDone();
    return _lstDoctorAppointmentDone;
  }

  void _handleDelete(int appointmentId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await UserBookService().removeBook(appointmentId, {});
      ToastUtil.toastSuccess(context: context, title: 'Hủy lịch hẹn thành công!', message: '');
      await _fetchLstDoctorAppointmentDone();
    } catch (error) {
      ToastUtil.toastError(context: context, title: 'Hủy lịch hẹn thất bại', message: error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class AppointmentInfoCard extends StatelessWidget {
  final DoctorAppointmentDoneResponse doctorAppointmentDone;
  final void Function(int) onDelete;

  const AppointmentInfoCard({
    super.key,
    required this.doctorAppointmentDone,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(MyColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('lib/assets/doctor2.png'),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(doctorAppointmentDone.doctor.name, style: const TextStyle(color: Colors.white)),
                            const SizedBox(height: 2),
                            Text(
                              doctorAppointmentDone.doctor.degree,
                              style: TextStyle(color: Color(MyColors.text01)),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Xác nhận'),
                                        content: const Text('Bạn có chắc chắn muốn hủy lịch hẹn này không?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Hủy'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                              onDelete(doctorAppointmentDone.id);
                                            },
                                            child: const Text('Xác nhận'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.white,
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AppointmentTimeCard(
                      date: doctorAppointmentDone.date,
                      endTime: doctorAppointmentDone.endTime,
                      startTime: doctorAppointmentDone.startTime,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(MyColors.bg01),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Tên bệnh nhân: ',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Nguyễn Văn A',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Số điện thoại: ',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                doctorAppointmentDone.phone.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Tuổi: ',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                doctorAppointmentDone.age.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Cân nặng: ',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${doctorAppointmentDone.weight} kg',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg02),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg03),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

class AppointmentTimeCard extends StatelessWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final DateTime date;

  const AppointmentTimeCard({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    String dateFormat = DateUtil.formatDateVN(date);
    String timeFormat = DateUtil.formatTimeRange(startTime, endTime);

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF4A4A58), // Assuming MyColors.bg01 is a hex value
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 10,
          ),
          const SizedBox(width: 5),
          Text(
            dateFormat,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              timeFormat,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
