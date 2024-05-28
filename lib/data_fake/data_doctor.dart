import 'package:app_medicine/model/doctors.dart';
import 'package:app_medicine/model/khoa.dart';

List<Doctors> generateDoctorList() {
  return [
    Doctors(
      doctorId: 1,
      name: 'Mai Thanh Nam',
      address: 'Mai Thanh Nam',
      phoneNumber: 'Mai Thanh Nam',
      gender: 'Mai Thanh Nam',
      mail: 'Mai Thanh Nam',
      khoa: Khoa(id: 'K02', name: 'Khoa than kinh'),
      bangcap: 'Eo co',
      image: "lib/assets/doctor2.png",
    ),
    Doctors(
      doctorId: 2,
      name: 'Dr. John Doe',
      address: '123 Main St',
      phoneNumber: '555-1234',
      gender: 'Male',
      mail: 'john.doe@example.com',
      khoa: Khoa(id: 'K02', name: 'Khoa than kinh'),
      bangcap: 'MD',
      image: "lib/assets/doctor2.png",
    )
  ];
}
