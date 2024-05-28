import 'nhomMau.dart';
import 'tienSuBenh.dart';

class Patients {
  final int patientId;
  final String name;
  final String address;
  final String phoneNumber;
  final String gender;
  final String height;
  final String weight;
  final nhom_mau Mhom_mau;
  final tien_su_benh Tien_su_benh;


  Patients(
      {required this.patientId,
        required this.name,
        required this.address,
        required this.phoneNumber,
        required this.gender,
        required this.height,
        required this.weight,
        required this.Mhom_mau,
        required this.Tien_su_benh});
}