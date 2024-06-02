import 'package:app_medicine/screens/Admin.dart';
import 'package:app_medicine/screens/patients_detail.dart';
import 'package:app_medicine/screens/prescription_search.dart';
import 'package:app_medicine/widgets/auth_check_widget.dart';
import 'package:flutter/material.dart';
import '../screens/AppointmentBookingScreen.dart';
import '../screens/auth/login.dart';
import '../screens/doctor_detail.dart';
import '../screens/home.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const AuthCheckWidget(child: Home()),
  '/admin': (context) => const Admin(),
  '/detail': (context) => const SliverDoctorDetail(),
  '/patientDetail': (context) => const SliverPatientDetail(),
  '/login': (context) => const LoginScreen(),
  '/prescription': (context) => PrescriptionSearchTab(),
  '/AppointmentBooking' : (context) => AppointmentBookingScreen(),
};
