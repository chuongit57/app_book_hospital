
import 'dart:convert';
import 'dart:io';

import 'package:app_medicine/constant/app_constant.dart';
import 'package:app_medicine/model/doctor_appointment.dart';
import 'package:app_medicine/service/api_service.dart';
import 'package:intl/intl.dart';

class UserBookService {

  Future<void> book(int? id, Map<String, dynamic> body) async {
    if (id != null) {
      body['doctorAppointmentId'] = id;
    }

    final response = await ApiService.postToken(AppConstant.USER_BOOK_BOOK, body);
    if (response.statusCode == HttpStatus.ok) {
    } else {
      throw Exception('Failed to getDoctorAppointmentSignUp');
    }
  }

}