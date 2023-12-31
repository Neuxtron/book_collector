// ignore_for_file: invalid_use_of_protected_member

import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/models/repositories/book_repository.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  final _bookRepository = BookRepository();

  BookStatus _bookStatus = BookStatus.loading;
  BookStatus get bookStatus => _bookStatus;

  final RxList<BookModel> _booksList = <BookModel>[].obs;
  List<BookModel> get booksList => _booksList.value;

  @override
  void onInit() {
    super.onInit();
    fetchAllBooks();
  }

  Future fetchAllBooks() async {
    print("AAAAAAAAAA");
    try {
      final booksList = await _bookRepository.fetchAllBooks();
      _booksList.assignAll(booksList);
      _bookStatus = BookStatus.normal;
      update();
    } catch (_) {
      _bookStatus = BookStatus.failed;
      update();
      rethrow;
    }
  }

  Future createBook(BookModel model) async {
    try {
      _bookStatus = BookStatus.loading;
      update();
      await _bookRepository.createBook(model);
      _bookStatus = BookStatus.normal;
      update();
    } catch (_) {
      _bookStatus = BookStatus.failed;
      update();
      rethrow;
    }
  }

  Future editBook(BookModel model) async {
    try {
      _bookStatus = BookStatus.loading;
      update();
      await _bookRepository.editBook(model);
      _bookStatus = BookStatus.normal;
      update();
    } catch (_) {
      _bookStatus = BookStatus.failed;
      update();
      rethrow;
    }
  }

  Future deleteBook(int id) async {
    try {
      _bookStatus = BookStatus.loading;
      update();
      await _bookRepository.deleteBook(id);
      _bookStatus = BookStatus.normal;
      update();
    } catch (_) {
      _bookStatus = BookStatus.failed;
      update();
      rethrow;
    }
  }
}

enum BookStatus { normal, loading, failed }
