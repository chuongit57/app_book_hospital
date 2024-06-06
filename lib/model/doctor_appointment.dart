import 'package:app_medicine/model/appointment.dart';
import 'package:app_medicine/model/department.dart';

class DoctorAppointment {
  final String code;
  final String name;
  final String yearOfBirth;
  final String address;
  final String phone;
  final String email;
  final String gender;
  final Department department;
  final String degree;
  final double numberOfStars;
  final int id;
  final List<Appointment> appointments;

  DoctorAppointment({
    required this.code,
    required this.name,
    required this.yearOfBirth,
    required this.address,
    required this.phone,
    required this.email,
    required this.gender,
    required this.department,
    required this.degree,
    required this.numberOfStars,
    required this.id,
    required this.appointments,
  });

  factory DoctorAppointment.fromJson(Map<String, dynamic> json) {
    return DoctorAppointment(
      code: json['code'],
      name: json['name'],
      yearOfBirth: json['yearOfBirth'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      gender: json['gender'],
      department: Department.fromJson(json['department']),
      degree: json['degree'],
      numberOfStars: json['numberOfStars'].toDouble(),
      id: json['id'].toInt(),
      appointments: (json['appointments'] as List)
          .map((appointment) => Appointment.fromJson(appointment))
          .toList(),
    );
  }
}
