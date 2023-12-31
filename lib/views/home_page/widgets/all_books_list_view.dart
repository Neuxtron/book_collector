import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/views/widgets/books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBooksListView extends StatelessWidget {
  final String searchText;
  final Function(dynamic value) onBack;

  const AllBooksListView({
    super.key,
    required this.onBack,
    required this.searchText,
  });

  @override
  Widget build(BuildContext context) {
    BookController controller = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
          child: Text(
            "Buku Anda",
            style: TextStyle(
              fontSize: 21,
              color: Colors.black.withOpacity(.18),
              fontWeight: FontWeight.bold,
              // IDEA: font family to arial rounded
            ),
          ),
        ),
        Obx(() {
          final booksList = controller.booksList;
          List<BookModel> searchedBooksList = booksList.where((book) {
            final bookTitle = book.title.toLowerCase();
            final searchTextLower = searchText.toLowerCase();
            return bookTitle.contains(searchTextLower);
          }).toList();
          return Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: BooksListView(
              booksList: searchText.isEmpty ? booksList : searchedBooksList,
              onBack: onBack,
            ),
          );
        })
      ],
    );
  }
}
