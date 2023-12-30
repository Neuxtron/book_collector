import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/controllers/user_controller.dart';
import 'package:get/get.dart';

class InitDep implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => BookController());
  }
}
