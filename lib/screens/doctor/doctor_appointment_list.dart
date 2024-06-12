import 'package:flutter/material.dart';
import 'package:app_medicine/model/doctor_appointment_upcoming_response.dart';
import 'doctor_appointment_card.dart';

class DoctorAppointmentList extends StatelessWidget {
  final Future<List<DoctorAppointmentUpcomingResponse>> futureAppointments;
  final VoidCallback onLoad; // Callback để tải lại dữ liệu

  const DoctorAppointmentList({
    Key? key,
    required this.futureAppointments,
    required this.onLoad, // Nhận callback từ DoctorScheduleScreen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DoctorAppointmentUpcomingResponse>>(
      future: futureAppointments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Hiện tại chưa có lịch hẹn nào'));
        } else {
          final appointments = snapshot.data!;
          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return DoctorAppointmentCard(
                appointment: appointment,
                onLoad: onLoad, // Truyền callback xuống DoctorAppointmentCard
              );
            },
          );
        }
      },
    );
  }
}
