import 'dart:developer';
import 'dart:io';

import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/models/services/book_service.dart';
import 'package:book_collector/models/utils/constants/dio_api.dart';
import 'package:intl/intl.dart';

class BookRepository {
  final _bookService = BookService();

  Future fetchAllBooks() async {
    try {
      final response = await _bookService.getBooksResponse();
      final jsonData = response["data"] as List;
      List<BookModel> booksList =
          jsonData.map((e) => BookModel.fromJson(e)).toList();
      return booksList;
    } on SocketException catch (e) {
      log(e.message);
      final message =
          "Failed to connect to server: ${DioApi.dio.options.baseUrl}";
      throw SocketException(message);
    } catch (_) {
      rethrow;
    }
  }

  Future createBook(BookModel model) async {
    try {
      await _bookService.createBookResponse(
        model.isbn,
        model.title,
        model.series,
        model.author,
        DateFormat('yyyy-MM-dd').format(model.publishedDate),
        model.publisher,
        model.pageCount,
        model.description,
        model.image,
      );
    } on SocketException catch (e) {
      log(e.message);
      final message =
          "Failed to connect to server: ${DioApi.dio.options.baseUrl}";
      throw SocketException(message);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future editBook(BookModel model) async {
    try {
      await _bookService.editBookResponse(
        model.id!,
        model.isbn,
        model.title,
        model.series,
        model.author,
        DateFormat('yyyy-MM-dd').format(model.publishedDate),
        model.publisher,
        model.pageCount,
        model.description,
        model.image,
      );
    } on SocketException catch (e) {
      log(e.message);
      final message =
          "Failed to connect to server: ${DioApi.dio.options.baseUrl}";
      throw SocketException(message);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
