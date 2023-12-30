import 'package:book_collector/models/utils/constants/dio_api.dart';
import 'package:book_collector/models/utils/helpers/api_helper.dart';

class BookService {
  final helper = ApiHelper();

  Future getBooksResponse() async {
    final dio = DioApi.dio;
    const endpoint = "/books";
    final response = await dio.get(endpoint);
    final jsonResponse = response.data;

    if (response.statusCode == 200) {
      return jsonResponse;
    }
    helper.handleExceptions(response.statusCode, jsonResponse["message"]);
  }
}
