import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/views/widgets/books_list_view.dart';
import 'package:flutter/material.dart';

class AllBooksListView extends StatelessWidget {
  final List<BookModel> booksList;
  final Function(dynamic value) onBack;

  const AllBooksListView({
    super.key,
    required this.booksList,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
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
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: BooksListView(
            booksList: booksList,
            onBack: onBack,
          ),
        )
      ],
    );
  }
}
