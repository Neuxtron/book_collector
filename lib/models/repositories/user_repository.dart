import 'dart:developer';
import 'dart:io';

import 'package:book_collector/models/services/user_service.dart';
import 'package:book_collector/models/utils/constants/dio_api.dart';
import 'package:book_collector/utils/constants/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final _userService = UserService();

  Future login(String email, String password) async {
    try {
      final response = await _userService.getLoginResponse(email, password);
      final prefs = await SharedPreferences.getInstance();

      final token = response["token"];
      log(token); // TODO: remove
      DioApi.token = token;
      prefs.setString(PrefKeys.userToken, token);
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

  Future logout() async {
    try {
      await _userService.logoutUser();
    } catch (_) {
      rethrow;
    }
  }
}
