import 'package:book_collector/models/repositories/user_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final _userRepository = UserRepository();
  UserStatus userStatus = UserStatus.normal;

  Future login(String email, String password) async {
    try {
      userStatus = UserStatus.loading;
      update();
      await _userRepository.login(email, password);
      userStatus = UserStatus.normal;
      update();
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
}

enum UserStatus { normal, loading }
