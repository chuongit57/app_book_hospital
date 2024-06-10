import 'package:app_medicine/model/bloodgroup.dart';

class Patient {
  final int code;
  final String name;
  final int yearOfBirth;
  final String address;
  final String phone;
  final String email;
  final String gender;
  final String height;
  final String weight;
  final Bloodgroup bloodgroup;
  final String healthcardnumber;
  final String anamnesis;
  final String note;

  Patient(
      {required this.code,
      required this.name,
      required this.yearOfBirth,
      required this.address,
      required this.phone,
        required this.email,
      required this.gender,
      required this.height,
      required this.weight,
      required this.bloodgroup,
      required this.healthcardnumber,
      required this.anamnesis,
      required this.note});
}
