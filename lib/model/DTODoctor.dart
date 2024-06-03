class DTODoctor {
  final int doctorId;
  final String name;
  final String degree;
  final String phoneNumber;
  final String department;
  final String examination_hours;

  DTODoctor({
    required this.doctorId,
    required this.name,
    required this.degree,
    required this.phoneNumber,
    required this.department,
    required this.examination_hours,
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
