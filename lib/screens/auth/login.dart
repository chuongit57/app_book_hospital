import 'dart:convert';
import 'dart:io';

import 'package:app_medicine/model/role.dart';
import 'package:app_medicine/model/user.dart';
import 'package:app_medicine/screens/auth/signup.dart';
import 'package:app_medicine/screens/doctor_home.dart';
import 'package:app_medicine/service/auth_service.dart';
import 'package:app_medicine/widgets/error_alert.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final username = TextEditingController();
  final password = TextEditingController();

  //A bool variable for show and hide password
  bool isVisible = false;

  //Here is our bool variable
  bool isLoginTrue = false;

  final authService = AuthService();

  Future login() async {
    var user = User();
    user.email = username.text;
    user.password = password.text;
    var result = await authService.signIn(user);
    if (result.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> resultData = jsonDecode(result.body);
      // Luu Token
      // Chia quyen
      user = User();
      var dataUser = jsonDecode(jsonEncode(resultData['user']));
      user.email = dataUser['email'];
      user.role = RoleExtension.fromString(dataUser['role']);
      user.lastname = dataUser['lastname'];
      user.firstname = dataUser['firstname'];
      if (user.role == Role.ADMIN) {
        print("Dang phat trien");
      } else if (user.role == Role.USER) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
      } else if (user.role == Role.DOCTOR) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DoctorHome()));
      }
    } else if (result.statusCode == HttpStatus.unauthorized) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorAlert(errorMessage: "Sai mail or sai mk");
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorAlert(errorMessage: result.body);
        },
      );
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            //We put all our textfield to a form to be controlled and not allow as empty
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  //Username field

                  //Before we show the image, after we copied the image we need to define the location in pubspec.yaml
                  Image.asset(
                    "lib/assets/login.png",
                    width: 210,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: username,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Tên đăng nhập là cần thiết";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Tên đăng nhập",
                      ),
                    ),
                  ),

                  //Password field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Mật khẩu là cần thiết";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Mật khẩu",
                          suffixIcon: IconButton(
                              onPressed: () {
                                //In here we will create a click to show and hide the password a toggle button
                                setState(() {
                                  //toggle button
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),

                  const SizedBox(height: 10),
                  //Login button
                  Container(
                    height: 55,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple),
                    child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            //Login method will be here
                            login();

                            //Now we have a response from our sqlite method
                            //We are going to create a user
                          }
                        },
                        child: const Text(
                          "ĐĂNG NHẬP",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),

                  //Sign up button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Chưa có tài khoản?"),
                      TextButton(
                          onPressed: () {
                            //Navigate to sign up
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: const Text("Đăng ký"))
                    ],
                  ),

                  // We will disable this message in default, when user and pass is incorrect we will trigger this message to user
                  isLoginTrue
                      ? const Text(
                    "Tên đăng nhập hoặc mật khẩu không chính xác",
                    style: TextStyle(color: Colors.red),
                  )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}