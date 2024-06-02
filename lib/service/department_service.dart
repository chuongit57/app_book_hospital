
import 'dart:convert';
import 'dart:io';

import 'package:app_medicine/constant/app_constant.dart';
import 'package:app_medicine/model/department.dart';
import 'package:app_medicine/service/api_service.dart';

class DepartmentService {

  Future<List<Department>> getSelectDepartments() async {
    final response = await ApiService.getToken(AppConstant.DEPARTMENT_GET_ALL);
    if (response.statusCode == HttpStatus.ok) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((department) => Department.fromJson(department)).toList();
    } else {
      throw Exception('Failed to load departments');
    }
  }

}