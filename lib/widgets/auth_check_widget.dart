import 'package:app_medicine/screens/auth/login.dart';
import 'package:app_medicine/service/auth_service.dart';
import 'package:flutter/material.dart';

class AuthCheckWidget extends StatelessWidget {
  final Widget child;

  const AuthCheckWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return FutureBuilder<bool>(
      future: authService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final isLoggedIn = snapshot.data!;
          if (isLoggedIn) {
            return child; // Render the child widget if logged in
          } else {
            return const LoginScreen(); // Redirect to login page if not logged in
          }
        } else if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString()); // Handle error
        } else {
          return CircularProgressIndicator(); // Show loading indicator while waiting for data
        }
      },
    );
  }
}