import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'horizontal_books_list_view.dart';

class RecentsSections extends StatefulWidget {
  final List<BookModel> booksList;
  const RecentsSections({super.key, required this.booksList});

  @override
  State<RecentsSections> createState() => _RecentsSectionsState();
}

class _RecentsSectionsState extends State<RecentsSections> {
  BookController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.updateRecentBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final recentBooks = controller.recentBooks;
      if (recentBooks.isEmpty) return const SizedBox();

      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: HorizontalBookListView(
          title: "Terakhir Dilihat",
          booksList: recentBooks,
          onBack: (value) => controller.updateAllBooks(),
        ),
      );
    });
  }
}
