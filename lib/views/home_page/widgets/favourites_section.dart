import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'horizontal_books_list_view.dart';

class FavouritesSection extends StatelessWidget {
  final Function(dynamic value) onBack;
  const FavouritesSection({super.key, required this.onBack});

  BookController get controller => Get.find();
  List<BookModel> get _favouriteBooks => controller.favouriteBooks;

  @override
  Widget build(BuildContext context) {
    if (_favouriteBooks.isEmpty) return const SizedBox();
    return Container(
      color: AppColors.primary.withOpacity(.12),
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.only(top: 20),
      child: Obx(() {
        return HorizontalBookListView(
          title: "Favorit",
          booksList: _favouriteBooks,
          onBack: onBack,
        );
      }),
    );
  }
}
