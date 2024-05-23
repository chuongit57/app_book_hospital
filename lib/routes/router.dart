import 'package:app_medicine/screens/Prescription.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../screens/auth/login.dart';
import '../screens/doctor_detail.dart';
import '../screens/home.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => Home(),
  '/detail': (context) => SliverDoctorDetail(),
  '/login': (context) => LoginScreen(),
  '/prescription': (context) => PrescriptionDetail(),
};
