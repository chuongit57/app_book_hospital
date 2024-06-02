import 'package:app_medicine/routes/router.dart';
import 'package:app_medicine/utils/textscale.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: fixTextScale,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
    );
  }
}