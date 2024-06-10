import 'package:app_medicine/model/department.dart';

class Doctor {
  final dynamic code;
  final dynamic name;
  final dynamic yearOfBirth;
  final dynamic address;
  final dynamic phone;
  final dynamic email;
  final dynamic gender;
  final dynamic degree;
  final Department department;
  final dynamic numberOfStars;


  Doctor(
      {required this.code,
        required this.name,
        required this.yearOfBirth,
        required this.address,
        required this.phone,
        required this.email,
        required this.gender,
        required this.degree,
        required this.department,
        required this.numberOfStars});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      code: json['code'],
      name: json['name'],
      yearOfBirth: json['yearOfBirth'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      gender: json['gender'],
      degree: json['degree'],
      department: Department(code: json['department']['code'], name: json['department']['name']),
      numberOfStars: json['numberOfStars'],
    );
  }
}
