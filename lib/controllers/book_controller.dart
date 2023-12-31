// ignore_for_file: invalid_use_of_protected_member

import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/models/repositories/book_repository.dart';
import 'package:book_collector/utils/constants/pref_keys.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookController extends GetxController {
  final _bookRepository = BookRepository();

  BookStatus _bookStatus = BookStatus.loading;
  BookStatus get bookStatus => _bookStatus;

  final RxList<BookModel> _booksList = <BookModel>[].obs;
  List<BookModel> get booksList => _booksList.value;

  final RxList<BookModel> _favouriteBooks = <BookModel>[].obs;
  List<BookModel> get favouriteBooks => _favouriteBooks.value;

  final RxList<BookModel> _recentBooks = <BookModel>[].obs;
  List<BookModel> get recentBooks => _recentBooks.value;

  @override
  void onInit() {
    super.onInit();
    fetchAllBooks();
  }

  Future fetchAllBooks() async {
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

  void updateFavouriteBooks() async {
    await fetchAllBooks();
    final prefs = await SharedPreferences.getInstance();
    final rawIds = prefs.getStringList(PrefKeys.favouriteIds) ?? [];
    final ids = rawIds.map((e) => int.tryParse(e) ?? -1).toList();

    List<BookModel> favouriteBooks = [];
    for (var id in ids) {
      final book = _booksList.firstWhereOrNull((book) {
        return book.id == id;
      });
      if (book != null) favouriteBooks.add(book);
    }

    _favouriteBooks.assignAll(favouriteBooks);
  }

  void updateRecentBooks() async {
    await fetchAllBooks();
    final prefs = await SharedPreferences.getInstance();
    final rawIds = prefs.getStringList(PrefKeys.recentIds) ?? [];
    final ids = rawIds.map((e) => int.tryParse(e) ?? -1).toList();

    List<BookModel> recentBooks = [];
    for (var id in ids) {
      final book = _booksList.firstWhereOrNull((book) {
        return book.id == id;
      });
      if (book != null) recentBooks.add(book);
    }

    _recentBooks.assignAll(recentBooks);
  }

  void updateAllBooks() {
    updateFavouriteBooks();
    updateRecentBooks();
  }
}

enum BookStatus { normal, loading, failed }
