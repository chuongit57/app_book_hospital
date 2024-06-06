class Appointment {
  final String startTime;
  final String endTime;
  final String date;
  final DoctorAppointmentStatus status;
  final int id;


  Appointment({
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.status,
    required this.id,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      startTime: json['startTime'],
      endTime: json['endTime'],
      date: json['date'],
      id: json['id'].toInt(),
      status: DoctorAppointmentStatus.values.firstWhere((e) => e.toString() == 'DoctorAppointmentStatus.' + json['status']),
    );
  }
}

enum DoctorAppointmentStatus {
  AVAILABLE,
  BOOKED,
  CANCELLED
}
