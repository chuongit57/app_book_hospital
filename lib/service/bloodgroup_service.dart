
import 'dart:convert';
import 'dart:io';

import 'package:app_medicine/constant/app_constant.dart';
import 'package:app_medicine/model/bloodgroup.dart';
import 'package:app_medicine/service/api_service.dart';

class BloodGroupService {

  Future<List<Bloodgroup>> getBloodGroup() async {
    final response = await ApiService.getToken(AppConstant.BLOODGROUP_GET_ALL);
    if (response.statusCode == HttpStatus.ok) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((bloodgroup) => Bloodgroup.fromJson(bloodgroup)).toList();
    } else {
      throw Exception('Failed to load departments');
    }
  }

}