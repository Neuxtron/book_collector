import 'package:book_collector/controllers/login_controller.dart';
import 'package:get/get.dart';

class InitDep implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
  }
}
