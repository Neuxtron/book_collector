class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() {
    return message;
  }
}

class ServerException extends AppException {
  ServerException(super.message);
}
