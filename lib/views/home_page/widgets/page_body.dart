import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/views/widgets/error_builder.dart';
import 'package:book_collector/views/widgets/loading_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'all_books_list_view.dart';
import 'favourites_section.dart';
import 'recents_section.dart';

class PageBody extends StatefulWidget {
  final String searchText;
  final BookController bookController;

  const PageBody({
    super.key,
    required this.bookController,
    required this.searchText,
  });

  @override
  State<PageBody> createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  void onBack(value) {
    widget.bookController.updateAllBooks();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.bookController.updateAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    widget.bookController.fetchAllBooks();
    widget.bookController.updateAllBooks();
    return GetBuilder<BookController>(builder: (_) {
      final bookStatus = widget.bookController.bookStatus;

      if (bookStatus == BookStatus.loading) return const LoadingBuilder();
      if (bookStatus == BookStatus.failed &&
          widget.bookController.booksList.isEmpty) {
        return const ErrorBuilder();
      }

      return Column(
        children: [
          widget.searchText.isEmpty
              ? FavouritesSection(
                  onBack: onBack,
                )
              : const SizedBox(),
          widget.searchText.isEmpty
              ? RecentsSections(
                  onBack: onBack,
                )
              : const SizedBox(),
          const SizedBox(height: 50),
          AllBooksListView(
            searchText: widget.searchText,
            onBack: (value) => setState(() {}),
          ),
        ],
      );
    });
  }
}
