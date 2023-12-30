import 'package:book_collector/models/source/dummy_books.dart';
import 'package:book_collector/views/widgets/books_list_view.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, bottom: 20),
            child: Row(
              children: [
                Icon(
                  Icons.history_rounded,
                  size: 30,
                  color: Colors.blueGrey.shade700.withOpacity(.5),
                ),
                SizedBox(width: 10),
                Text(
                  "Riwayat",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.blueGrey.shade700.withOpacity(.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          BooksListView(booksList: DummyBooks.allBooks)
        ],
      ),
    );
  }
}
