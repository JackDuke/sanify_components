// ignore_for_file: prefer_if_null_operators

import 'user.dart';

class LoginResponseModel {
  // final String token;
  // final String error;
  final User? user;

  // LoginResponseModel({required this.token, required this.error, required this.user});
  LoginResponseModel({required this.user});

  // factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
  //   print(json);
  //   return LoginResponseModel(
  //       token: json['token'] != null ? json['token'] : '',
  //       error: json['error'] != null ? json['error'] : '',
  //       user: json);
  // }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
