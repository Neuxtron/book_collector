import 'dart:developer';

import 'package:book_collector/models/utils/constants/dio_api.dart';
import 'package:book_collector/models/utils/helpers/api_helper.dart';

class UserService {
  final dio = DioApi.dio;
  final helper = ApiHelper();

  Future getLoginResponse(email, password) async {
    const endpoint = "/login";
    final response = await dio.post(
      endpoint,
      data: {
        "email": email,
        "password": password,
      },
    );
    final jsonResponse = response.data;

    if (response.statusCode == 200) {
      return jsonResponse;
    }
    helper.handleExceptions(response.statusCode, jsonResponse["message"]);
  }

  Future getSignupResponse(name, email, password) async {
    const endpoint = "/register";
    final response = await dio.post(
      endpoint,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password,
      },
    );
    final jsonResponse = response.data;

    if (response.statusCode == 200) {
      return jsonResponse;
    }
    log(response.toString());
    helper.handleExceptions(response.statusCode, jsonResponse["message"]);
  }

  Future logoutUser() async {
    const endpoint = "/user/logout";
    final response = await dio.delete(endpoint);
    final jsonResponse = response.data;

    if (response.statusCode == 200) {
      return jsonResponse;
    }
    log(response.toString());
    helper.handleExceptions(response.statusCode, jsonResponse["message"]);
  }
}
