import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'horizontal_books_list_view.dart';

class FavouritesSection extends StatefulWidget {
  final List<BookModel> booksList;
  const FavouritesSection({super.key, required this.booksList});

  @override
  State<FavouritesSection> createState() => _FavouritesSectionState();
}

class _FavouritesSectionState extends State<FavouritesSection> {
  BookController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.updateRecentBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final favouriteBooks = controller.favouriteBooks;
      if (favouriteBooks.isEmpty) return const SizedBox();

      return Container(
        color: AppColors.primary.withOpacity(.12),
        padding: const EdgeInsets.symmetric(vertical: 20),
        margin: const EdgeInsets.only(top: 20),
        child: HorizontalBookListView(
          title: "Favorit",
          booksList: favouriteBooks,
          onBack: (value) => controller.updateAllBooks(),
        ),
      );
    });
  }
}
