import 'package:app_medicine/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:app_medicine/model/doctor_appointment_upcoming_response.dart';

import '../../component/appointment_time_card.dart';
import '../../service/user_book_service.dart';

class DoctorAppointmentCard extends StatelessWidget {
  final DoctorAppointmentUpcomingResponse appointment;
  final VoidCallback onLoad;

  const DoctorAppointmentCard({
    Key? key,
    required this.appointment, required this.onLoad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = UserBookService();
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
                            Text(appointment.name, style: const TextStyle(color: Colors.white)),
                            const SizedBox(height: 2),
                            Text(
                              'Bệnh nhân',
                              style: TextStyle(color: Color(MyColors.text01)),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  OutlinedButton(
                                    onPressed: () async {
                                      final TextEditingController reasonController = TextEditingController();
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Hoàn thành kham'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller: reasonController,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Lý do',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Hủy'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  // Hiển thị dialog loading
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Row(
                                                          children: [
                                                            CircularProgressIndicator(),
                                                            SizedBox(width: 20),
                                                            Text("Đang xử lý..."),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );

                                                  // Thực hiện xử lý
                                                  String reason = reasonController.text;
                                                  await service.doctorCompleted(appointment.id, reason);

                                                  // Đóng dialog loading và thông báo cần tải lại dữ liệu
                                                  Navigator.of(context).pop(); // Đóng dialog loading
                                                  Navigator.of(context).pop(); // Đóng dialog hoàn thành
                                                  onLoad(); // Gọi hàm callback để thông báo cần tải lại dữ liệu
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
                                      Icons.done_outlined,
                                      color: Colors.white,
                                    ),
                                  ),

                                  const SizedBox(width: 5),
                                  OutlinedButton(
                                    onPressed: () async {
                                      final TextEditingController reasonController = TextEditingController();

                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Hủy cuộc hẹn'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller: reasonController,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Lý do',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Hủy'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  // Hiển thị dialog loading
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Row(
                                                          children: [
                                                            CircularProgressIndicator(),
                                                            SizedBox(width: 20),
                                                            Text("Đang xử lý..."),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );

                                                  // Thực hiện xử lý
                                                  String reason = reasonController.text;
                                                  await service.doctorCancel(appointment.id, reason);

                                                  // Đóng dialog loading và thông báo cần tải lại dữ liệu
                                                  Navigator.of(context).pop(); // Đóng dialog loading
                                                  Navigator.of(context).pop(); // Đóng dialog hoàn thành
                                                  onLoad(); // Gọi hàm callback để thông báo cần tải lại dữ liệu
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
                                      Icons.cancel_outlined,
                                      color: Colors.white,
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    AppointmentTimeCard(
                      date: appointment.date,
                      endTime: appointment.endTime,
                      startTime: appointment.startTime,
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
                                appointment.name == null ? '' : '${appointment.name}',
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
                                appointment.gender == null ? '' : '${appointment.gender}',
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
                                appointment.phone == null ? '' : '${appointment.phone}',
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
                                appointment.age == null ? '' : '${appointment.age}',
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
                                appointment.weight == null ? '' : '${appointment.weight} kg',
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
                                appointment.height == null ? '' : '${appointment.height} cm',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Mô tả: ',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                appointment.description == null ? '' : '${appointment.description}',
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
