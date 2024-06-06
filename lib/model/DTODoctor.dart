class DTODoctor {
  final int doctorId;
  final String name;
  final int year_Of_Birth;
  final String degree;
  final String email;
  final String phoneNumber;
  final String adress;
  final String department;
  final String gender;
  final String examination_hours;
  final double number_of_start;

  DTODoctor({
    required this.doctorId,
    required this.name,
    required this.year_Of_Birth,
    required this.degree,
    required this.email,
    required this.phoneNumber,
    required this.adress,
    required this.department,
    required this.gender,
    required this.examination_hours,
    required this.number_of_start,
  });

  get description => null;

  get patientCount => "100+";

  get experience => "3 năm";

  get rating => "4.3";

}

class DTODoctorDetail {
  final DTODoctor? doctor;
  final String reservedDate;
  final String reservedTime;
  final String status;

  DTODoctorDetail({
    required this.doctor,
    required this.reservedDate,
    required this.reservedTime,
    required this.status,
  });
}
