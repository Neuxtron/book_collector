import 'dart:developer';

import 'package:book_collector/models/repositories/user_repository.dart';
import 'package:book_collector/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final _userRepository = UserRepository();
  UserStatus userStatus = UserStatus.normal;
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future login(String email, String password) async {
    try {
      userStatus = UserStatus.loading;
      update();
      await _userRepository.login(email, password);
      userStatus = UserStatus.normal;
      update();
      getProfile();
    } catch (_) {
      userStatus = UserStatus.normal;
      update();
      rethrow;
    }
  }

  Future signup(String name, String email, String password) async {
    try {
      userStatus = UserStatus.loading;
      update();
      await _userRepository.signup(name, email, password);
      userStatus = UserStatus.normal;
      update();
    } catch (_) {
      userStatus = UserStatus.normal;
      update();
      rethrow;
    }
  }

  Future logout() async {
    try {
      userStatus = UserStatus.loading;
      update();
      await _userRepository.logout();
      userStatus = UserStatus.normal;
      update();
    } catch (_) {
      userStatus = UserStatus.normal;
      update();
      rethrow;
    }
  }

  Future getProfile() async {
    try {
      _currentUser = await _userRepository.getProfile();
      update();
      log(_currentUser.toString());
    } catch (_) {
      rethrow;
    }
  }
}

enum UserStatus { normal, loading }
