import 'package:flutter/material.dart';

class Appointment {
  int id;
  TimeOfDay startTime;
  TimeOfDay endTime;
  DateTime date;
  late DoctorAppointmentStatus status;

  Appointment({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      startTime: TimeOfDay(
        hour: int.parse(json['startTime'].split(":")[0]),
        minute: int.parse(json['startTime'].split(":")[1]),
      ),
      endTime: TimeOfDay(
        hour: int.parse(json['endTime'].split(":")[0]),
        minute: int.parse(json['endTime'].split(":")[1]),
      ),
      date: DateTime.parse(json['date']),
      status: DoctorAppointmentStatus.values.firstWhere((e) => e.toString() == 'DoctorAppointmentStatus.' + json['status']),
    );
  }
}

enum DoctorAppointmentStatus {
  AVAILABLE,
  BOOKED,
  CANCELLED
}