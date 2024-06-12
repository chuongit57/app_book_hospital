
import 'dart:convert';
import 'dart:io';

import 'package:app_medicine/constant/app_constant.dart';
import 'package:app_medicine/model/doctor_appointment.dart';
import 'package:app_medicine/model/doctor_appointment_upcoming_response.dart';
import 'package:app_medicine/service/api_service.dart';
import 'package:intl/intl.dart';

class UserBookService {

  Future<List<DoctorAppointmentUpcomingResponse>> getListUserAppointmentUpcoming(DateTime? date) async {
    Map<String, dynamic> body = {};

    if (date != null) {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      String formattedDate = dateFormat.format(date);
      body['date'] = formattedDate;
    }

    final response = await ApiService.postToken(AppConstant.USER_BOOK_LIST_BOOK, body);
    if (response.statusCode == HttpStatus.ok) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((d) => DoctorAppointmentUpcomingResponse.fromJson(d)).toList();
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> book(int? id, Map<String, dynamic> body) async {
    if (id != null) {
      body['doctorAppointmentId'] = id;
    }

    final response = await ApiService.postToken(AppConstant.USER_BOOK_BOOK, body);
    if (response.statusCode == HttpStatus.ok) {
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> removeBook(int? id, Map<String, dynamic> body) async {
    if (id != null) {
      body['doctorAppointmentId'] = id;
    }

    final response = await ApiService.postToken(AppConstant.USER_BOOK_REMOVE_BOOK, body);
    if (response.statusCode == HttpStatus.ok) {
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> doctorCompleted(int? id, String detail) async {
    Map<String, dynamic> body = {};
    if (id != null) {
      body['doctorAppointmentId'] = id;
    }
    body['detail'] = detail;
    final response = await ApiService.postToken(AppConstant.USER_BOOK_DOCTOR_COMPLETED, body);
    if (response.statusCode == HttpStatus.ok) {
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> doctorCancel(int? id, String detail) async {
    Map<String, dynamic> body = {};
    if (id != null) {
      body['doctorAppointmentId'] = id;
    }
    body['detail'] = detail;
    final response = await ApiService.postToken(AppConstant.USER_BOOK_DOCTOR_CANCEL, body);
    if (response.statusCode == HttpStatus.ok) {
    } else {
      throw Exception(response.body);
    }
  }

}