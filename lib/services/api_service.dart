// ignore_for_file: unused_local_variable

// import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/user.dart';
import '../model/login_model.dart';

class APIService {
  Future<User> login(LoginRequestModel requestModel) async {
    String url = "http://10.0.2.2:8082/api/v1/login";

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestModel));
    if (response.statusCode == 200 || response.statusCode == 400) {
      // return LoginResponseModel.fromJson(json.decode(response.body));
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }

    // final data = { 'email': requestModel.email, 'password': requestModel.password };

    // final dio = Dio();
    // Response response;
    // response = await dio.post(url, data: data);

    // if (response.statusCode == 200) {
    //   message = "Successfully logged in!";
    // }

    // return message;
  }
}
