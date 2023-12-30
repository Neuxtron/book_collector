import 'dart:developer';

import 'package:book_collector/models/utils/constants/app_exceptions.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class ApiHelper {
  void handleExceptions(int? statusCode, String message,
      {String responseBody = ""}) {
    switch (statusCode) {
      case 401:
        log("Status code: $statusCode\nMessage: $responseBody");
        throw UnauthorizedException();
      case 422:
        log("Status code: $statusCode\nMessage: $responseBody");
        throw BadRequestException(message);
      case 500:
        log("Status code: $statusCode\nMessage: $responseBody");
        throw ServerException(message);
      default:
        log("Status code: $statusCode\nMessage: $message");
        throw Exception();
    }
  }
}
