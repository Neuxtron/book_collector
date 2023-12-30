import 'package:book_collector/models/utils/constants/dio_api.dart';
import 'package:book_collector/models/utils/helpers/api_helper.dart';

class UserService {
  final dio = DioApi.dio;
  final helper = ApiHelper();
  final endpoint = "/login";

  Future getLoginResponse(email, password) async {
    final response = await dio.post(
      endpoint,
      data: {
        "email": email,
        "password": password,
      },
    );
    final jsonResponse = response.data;

    if (response.statusCode == 200) {
      return jsonResponse;
    }
    helper.handleExceptions(response.statusCode, jsonResponse["message"]);
  }
}
