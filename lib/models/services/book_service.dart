import 'dart:convert';

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

  Future createBookResponse(
    String isbn,
    String title,
    String subtitle,
    String author,
    String published,
    String publisher,
    int pages,
    String description,
    String website,
  ) async {
    final dio = DioApi.dio;
    const endpoint = "/books/add";

    final body = {
      "isbn": isbn,
      "title": title,
      "subtitle": subtitle,
      "author": author,
      "published": published,
      "publisher": publisher,
      "pages": pages,
    };
    if (website.isNotEmpty) body["website"] = website;
    if (description.isNotEmpty) body["description"] = description;

    final response = await dio.post(
      endpoint,
      data: jsonEncode(body),
    );
    final jsonResponse = response.data;

    if (response.statusCode == 200) {
      return jsonResponse;
    }
    helper.handleExceptions(response.statusCode, jsonResponse["message"],
        responseBody: response.toString());
  }

  Future editBookResponse(
    int id,
    String isbn,
    String title,
    String subtitle,
    String author,
    String published,
    String publisher,
    int pages,
    String description,
    String website,
  ) async {
    final dio = DioApi.dio;
    final endpoint = "/books/$id/edit";

    final body = {
      "isbn": isbn,
      "title": title,
      "subtitle": subtitle,
      "author": author,
      "published": published,
      "publisher": publisher,
      "pages": pages,
    };
    if (website.isNotEmpty) body["website"] = website;
    if (description.isNotEmpty) body["description"] = description;

    final response = await dio.put(
      endpoint,
      data: jsonEncode(body),
    );
    final jsonResponse = response.data;

    if (response.statusCode == 200) {
      return jsonResponse;
    }
    helper.handleExceptions(response.statusCode, jsonResponse["message"],
        responseBody: response.toString());
  }
}
