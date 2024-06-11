
import 'dart:convert';
import 'dart:io';

import 'package:app_medicine/constant/app_constant.dart';
import 'package:app_medicine/model/doctor_appointment.dart';
import 'package:app_medicine/model/doctor_appointment_done_response.dart';
import 'package:app_medicine/service/api_service.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentService {

  Future<List<DoctorAppointment>> getDoctorAppointmentSignUp(DateTime? date, String? departmentCode) async {
    Map<String, dynamic> body = {};
    if (departmentCode != null) {
      body['departmentCode'] = departmentCode;
    }

    if (date != null) {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      String formattedDate = dateFormat.format(date);
      body['date'] = formattedDate;
    }

    final response = await ApiService.postToken(AppConstant.DOCTOR_APPOINTMENT_SIGN_UP, body);
    if (response.statusCode == HttpStatus.ok) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((doctorAppointment) => DoctorAppointment.fromJson(doctorAppointment)).toList();
    } else {
      throw Exception(response.body);
    }
  }

  Future<List<DoctorAppointmentDoneResponse>> getListDoctorAppointmentDone() async {

    final response = await ApiService.getToken(AppConstant.DOCTOR_APPOINTMENT_DONE);
    if (response.statusCode == HttpStatus.ok) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((doctorAppointmentDoneResponse) => DoctorAppointmentDoneResponse.fromJson(doctorAppointmentDoneResponse)).toList();
    } else {
      throw Exception('Failed to getDoctorAppointmentSignUp');
    }
  }

}