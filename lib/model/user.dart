//In here first we create the users json model
// To parse this JSON data, do
//

import 'package:app_medicine/model/role.dart';

class User {
  int? id;
  String? firstname;
  String? lastname;
  late String? email;
  String? password;
  Role? role;
  String? tokens;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.role,
    this.tokens,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      role: RoleExtension.fromString(json['role']),
      tokens: json['token'],
    );
  }

  // Method to convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'role': role.toString().split('.').last,
      'tokens': tokens,
    };
  }
}
