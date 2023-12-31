import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'horizontal_books_list_view.dart';

class RecentsSections extends StatelessWidget {
  final Function(dynamic value) onBack;
  const RecentsSections({super.key, required this.onBack});

  BookController get controller => Get.find();
  List<BookModel> get _recentBooks => controller.recentBooks;

  @override
  Widget build(BuildContext context) {
    if (_recentBooks.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Obx(() {
        return HorizontalBookListView(
          title: "Terakhir Dilihat",
          booksList: _recentBooks,
          onBack: onBack,
        );
      }),
    );
  }
}
