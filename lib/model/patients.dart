import 'nhomMau.dart';
class Patients {
  final int patientId;
  final String name;
  final String address;
  final String phoneNumber;
  final String gender;
  final String height;
  final String weight;
  final nhom_mau nhomMau;
  final String tienSuBenh;
  final String note;
  Patients(
      {required this.patientId,
      required this.name,
      required this.address,
      required this.phoneNumber,
      required this.gender,
      required this.height,
      required this.weight,
      required this.nhomMau,
      required this.tienSuBenh,
      required this.note
      });
}
