import 'dart:io';

import 'package:app_medicine/constant/app_constant.dart';
import 'package:app_medicine/model/user.dart';
import 'package:app_medicine/service/api_service.dart';

import 'package:http/http.dart' as http;

class AuthService {

  Future<http.Response> signIn(User user) async {
    // call api signIp
    final response = await ApiService.post(AppConstant.SIGN_IN_URL, user.toJson());
    return response;
  }

  Future<http.Response> signUp(User user) async {
    // call api signUp
    final response = await ApiService.post(AppConstant.SIGN_UP_URL, user.toJson());
    return response;
  }

}