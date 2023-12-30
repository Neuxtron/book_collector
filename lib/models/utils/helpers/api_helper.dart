import 'dart:developer';

import 'package:book_collector/models/utils/constants/app_exceptions.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class ApiHelper {
  void handleExceptions(int? statusCode, String message) {
    switch (statusCode) {
      case 401:
        throw UnauthorizedException();
      case 422:
        throw BadRequestException(message);
      case 500:
        throw ServerException(message);
      default:
        log("Status code: $statusCode\nMessage: $message");
        throw Exception();
    }
  }
}
