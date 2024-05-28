import 'dart:io';

import 'package:app_medicine/model/role.dart';
import 'package:app_medicine/service/auth_service.dart';
import 'package:app_medicine/widgets/error_alert.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Role? _selectedRole = Role.ADMIN;
  final _authService = AuthService();

  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //SingleChildScrollView to have an scrol in the screen
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //We will copy the previous textfield we designed to avoid time consuming

                  const ListTile(
                    title: Text(
                      "Đăng ký tài khoản",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //As we assigned our controller to the textformfields

                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: username,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Tên đăng nhập là cần thiết";
                        }
                        if (value.length < 6) {
                          return "Tên đăng nhập tối thiểu là 6 kí tự";
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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Mật khẩu là cần thiết";
                        }
                        if (value.length < 6) {
                          return "Mật khẩu tối thiểu là 6 kí tự";
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
                              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off))),
                    ),
                  ),

                  //Confirm Password field
                  // Now we check whether password matches or not
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: confirmPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Mật khẩu là cần thiết";
                        } else if (password.text != confirmPassword.text) {
                          return "Mật khẩu không khớp";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Nhập lại mật khẩu",
                          suffixIcon: IconButton(
                              onPressed: () {
                                //In here we will create a click to show and hide the password a toggle button
                                setState(() {
                                  //toggle button
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off))),
                    ),
                  ),

                  const SizedBox(height: 10),
                  //Login button
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.deepPurple),
                    child: TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            User user = User();
                            user.email = username.text;
                            user.password = password.text;
                            user.role = Role.USER;
                            final result = await _authService.signUp(user);
                            if (result.statusCode == HttpStatus.ok) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ErrorAlert(errorMessage: result.body);
                                },
                              );
                            }
                          }
                        },
                        child: const Text(
                          "ĐĂNG KÝ",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),

                  //Sign up button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Bạn đã có tài khoản?"),
                      TextButton(
                          onPressed: () {
                            //Navigate to sign up
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          },
                          child: const Text("Đăng nhập"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
