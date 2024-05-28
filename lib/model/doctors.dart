import 'package:app_medicine/model/khoa.dart';

class Doctors {
  final int doctorId;
  final String name;
  final String address;
  final String phoneNumber;
  final String gender;
  final String mail;
  final Khoa khoa;
  final String bangcap;
  final String image;

  Doctors(
      {required this.doctorId,
      required this.name,
      required this.address,
      required this.phoneNumber,
      required this.gender,
      required this.mail,
      required this.khoa,
      required this.bangcap,
      required this.image});
}
