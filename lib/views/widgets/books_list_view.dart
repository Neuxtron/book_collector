import 'package:flutter/material.dart';

import '../../models/book_model.dart';
import 'book_list_item.dart';

class BooksListView extends StatelessWidget {
  final List<BookModel> booksList;
  const BooksListView({super.key, required this.booksList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: booksList.length,
      itemBuilder: (context, index) {
        final book = booksList[index];
        return BookListItem(
          model: book,
        );
      },
    );
  }
}
