import 'package:flutter/material.dart';

import '../../component/appointment_time_card.dart';
import '../../model/doctor_appointment_done_response.dart';
import '../../service/doctor_appointment_service.dart';
import '../../service/user_book_service.dart';
import '../../styles/colors.dart';
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
    return Expanded(
        child: Stack(
          children: [
            FutureBuilder<List<DoctorAppointmentDoneResponse>>(
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
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
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
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.white),
                                ),
                                child: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
                            children: [
                              const Text(
                                'Tên bệnh nhân: ',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                doctorAppointmentDone.name == null ? '' : '${doctorAppointmentDone.name}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Giới tính: ',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                doctorAppointmentDone.gender == null ? '' : '${doctorAppointmentDone.gender}',
                                style: const TextStyle(color: Colors.white),
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
                                doctorAppointmentDone.phone == null ? '' : '${doctorAppointmentDone.phone}',
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
                                doctorAppointmentDone.age == null ? '' : '${doctorAppointmentDone.age}',
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
                                doctorAppointmentDone.weight == null ? '' : '${doctorAppointmentDone.weight} kg',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Chiều cao: ',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                doctorAppointmentDone.height == null ? '' : '${doctorAppointmentDone.height} cm',
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

