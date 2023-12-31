import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/books_list_view.dart';
import 'package:book_collector/views/widgets/error_builder.dart';
import 'package:book_collector/views/widgets/loading_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  BookController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.updateFavouriteBooks();
  }

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
                  Icons.star,
                  color: AppColors.lightYelllow,
                ),
                const SizedBox(width: 10),
                Text(
                  "Buku Favorit",
                  style: TextStyle(
                    fontSize: 32,
                    color: AppColors.lightYelllow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Obx(
            () {
              final favouriteBooks = controller.favouriteBooks;
              return GetBuilder<BookController>(builder: (_) {
                if (controller.bookStatus == BookStatus.loading) {
                  return const LoadingBuilder();
                }
                if (controller.bookStatus == BookStatus.failed) {
                  return const ErrorBuilder();
                }

                if (favouriteBooks.isEmpty) {
                  return const Center(
                    child: Text("Tidak ada buku favorit"),
                  );
                }
                return BooksListView(
                  booksList: favouriteBooks,
                  onBack: (value) => controller.updateAllBooks(),
                );
              });
            },
          )
        ],
      ),
    );
  }
}
