import 'package:app_medicine/model/appointment.dart';
import 'package:app_medicine/model/doctor.dart';
import 'package:app_medicine/model/user.dart';
import 'package:flutter/material.dart';

class DoctorAppointmentDoneResponse {
  final dynamic id;
  final Doctor doctor;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final DateTime date;
  final DoctorAppointmentStatus status;
  final User user;
  final dynamic description;
  final dynamic age;
  final dynamic name;
  final dynamic weight;
  final dynamic height;
  final dynamic phone;
  final dynamic gender;

  DoctorAppointmentDoneResponse({
    required this.id,
    required this.doctor,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.status,
    required this.user,
    required this.description,
    required this.age,
    required this.weight,
    required this.height,
    required this.phone,
    required this.name,
    required this.gender
  });

  factory DoctorAppointmentDoneResponse.fromJson(Map<String, dynamic> json) {
    return DoctorAppointmentDoneResponse(
      id: json['id'],
      doctor: Doctor.fromJson(json['doctor']),
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
      user: User.fromJson(json['user']),
      description: json['description'],
      age: json['age'],
      weight: json['weight'],
      height: json['height'],
      phone: json['phone'],
      name: json['name'],
      gender: json['gender']
    );
  }

}