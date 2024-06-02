
import 'dart:convert';
import 'dart:io';

import 'package:app_medicine/constant/app_constant.dart';
import 'package:app_medicine/model/department.dart';
import 'package:app_medicine/model/doctor.dart';
import 'package:app_medicine/service/api_service.dart';

class DoctorService {

  Future<List<Doctor>> getListDoctorTop() async {
    final response = await ApiService.getToken(AppConstant.DOCTOR_LIST_DOCTOR_TOP);
    if (response.statusCode == HttpStatus.ok) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((doctor) => Doctor.fromJson(doctor)).toList();
    } else {
      throw Exception('Failed to load departments');
    }
  }

}