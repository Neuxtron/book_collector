import 'package:book_collector/models/source/dummy_books.dart';
import 'package:book_collector/views/widgets/books_list_view.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow.shade700.withOpacity(.7),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Buku Favorit",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.yellow.shade700.withOpacity(.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            BooksListView(booksList: DummyBooks.allBooks)
          ],
        ),
      ),
    );
  }
}
