import 'package:dio/dio.dart';

class DioApi {
  static final _dio = Dio();

  static Dio get dio {
    final options = BaseOptions(
      baseUrl: "https://book-crud-service-6dmqxfovfq-et.a.run.app/api",
      contentType: "application/json",
      headers: {
        "Accept": "application/json",
      },
      followRedirects: false,
      validateStatus: (status) => status! < 500,
    );
    _dio.options = options;
    return _dio;
  }

  static set token(String token) {
    _dio.options.headers = {
      "Authorization": token,
    };
  }
}
