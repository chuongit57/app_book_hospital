import 'package:app_medicine/model/filter_status.dart';
import 'package:app_medicine/model/nhomMau.dart';

List<Map> schedule_patient = [
  {
    'patientId': 1,
    'patientName': 'Mai Thanh Nam',
    'address': 'Mai Thanh Nam',
    'phoneNumber': 'Mai Thanh Nam',
    'gender': 'Mai Thanh Nam',
    'height': "165",
    'nhomMau': nhom_mau(id: '1', nhomMau: 'O'),
    'weight': '50',
    'tienSuBenh': "Tiểu đường, sơ gam",
    'reservedDate': 'Thứ 4, 15 tháng 5',
    'reservedTime': '08:00 - 17:00',
    'status': FilterStatus.Complete,
    'img': "lib/assets/doctor2.png",
  },
  {
    'patientId': 2,
    'patientName': 'Võ Quốc Bảo',
    'address': 'Mai Thanh Nam',
    'phoneNumber': 'Mai Thanh Nam',
    'gender': 'Mai Thanh Nam',
    'height': "165",
    'nhomMau': nhom_mau(id: '1', nhomMau: 'O'),
    'weight': '50',
    'tienSuBenh': "Tiểu đường, sơ gam",
    'reservedDate': 'Thứ 4, 15 tháng 5',
    'reservedTime': '08:00 - 17:00',
    'status': FilterStatus.Upcoming,
    'img': "lib/assets/doctor2.png",
  }
];
