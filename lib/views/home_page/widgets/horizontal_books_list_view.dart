import 'package:book_collector/models/book_model.dart';
import 'package:flutter/material.dart';

import 'book_tile.dart';

class HorizontalBookListView extends StatelessWidget {
  final String title;
  final List<BookModel> booksList;
  final Function(dynamic value) onBack;

  const HorizontalBookListView({
    super.key,
    required this.title,
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
            title,
            style: TextStyle(
              fontSize: 21,
              color: Colors.black.withOpacity(.18),
              fontWeight: FontWeight.bold,
              // IDEA: font family to arial rounded
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: booksList.length,
            itemBuilder: (context, index) {
              final book = booksList[index];
              return BookTile(
                model: book,
                onBack: onBack,
              );
            },
          ),
        ),
      ],
    );
  }
}
