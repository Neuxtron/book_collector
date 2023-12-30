import 'dart:developer';
import 'dart:io';

import 'package:book_collector/models/services/user_service.dart';
import 'package:book_collector/models/utils/constants/dio_api.dart';

class UserRepository {
  final _userService = UserService();

  Future login(String email, String password) async {
    try {
      final response = await _userService.getLoginResponse(email, password);
      DioApi.token = response["token"];
    } on SocketException catch (e) {
      log(e.message);
      final message =
          "Failed to connect to server: ${_userService.dio.options.baseUrl}";
      throw SocketException(message);
    } catch (_) {
      rethrow;
    }
  }

  Future signup(String name, String email, String password) async {
    try {
      await _userService.getSignupResponse(name, email, password);
    } on SocketException catch (e) {
      log(e.message);
      final message =
          "Failed to connect to server: ${_userService.dio.options.baseUrl}";
      throw SocketException(message);
    } catch (_) {
      rethrow;
    }
  }
}
