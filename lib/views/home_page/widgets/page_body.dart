import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/views/widgets/error_builder.dart';
import 'package:book_collector/views/widgets/loading_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'all_books_list_view.dart';
import 'favourites_section.dart';
import 'recents_section.dart';

class PageBody extends StatefulWidget {
  final BookController bookController;

  const PageBody({
    super.key,
    required this.bookController,
  });

  @override
  State<PageBody> createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  @override
  Widget build(BuildContext context) {
    widget.bookController.fetchAllBooks();
    return GetBuilder<BookController>(builder: (_) {
      final bookStatus = widget.bookController.bookStatus;

      if (bookStatus == BookStatus.loading) return const LoadingBuilder();
      if (bookStatus == BookStatus.failed &&
          widget.bookController.booksList.isEmpty) {
        return const ErrorBuilder();
      }

      return Obx(() => Column(
            children: [
              FavouritesSection(booksList: widget.bookController.booksList),
              RecentsSections(booksList: widget.bookController.booksList),
              const SizedBox(height: 50),
              AllBooksListView(
                booksList: widget.bookController.booksList,
                onBack: (value) => setState(() {}),
              ),
            ],
          ));
    });
  }
}
