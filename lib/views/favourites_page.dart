import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/utils/constants/pref_keys.dart';
import 'package:book_collector/views/widgets/books_list_view.dart';
import 'package:book_collector/views/widgets/error_builder.dart';
import 'package:book_collector/views/widgets/loading_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  BookController controller = Get.find();
  List<int> _favouriteIds = [];

  void getFavouriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final rawIds = prefs.getStringList(PrefKeys.favouriteIds) ?? [];
    final ids = rawIds.map((e) => int.tryParse(e) ?? -1).toList();
    setState(() => _favouriteIds = ids);
  }

  @override
  void initState() {
    super.initState();
    getFavouriteIds();
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
              if (controller.bookStatus == BookStatus.loading) {
                return const LoadingBuilder();
              }
              if (controller.bookStatus == BookStatus.failed) {
                return const ErrorBuilder();
              }
              List<BookModel> favouriteBooks = [];
              for (var id in _favouriteIds) {
                final book = controller.booksList.firstWhereOrNull((book) {
                  return book.id == id;
                });
                if (book != null) favouriteBooks.add(book);
              }

              if (favouriteBooks.isEmpty) {
                return const Center(
                  child: Text("Tidak ada buku favorit"),
                );
              }
              return BooksListView(
                booksList: favouriteBooks,
                onBack: (value) => getFavouriteIds(),
              );
            },
          )
        ],
      ),
    );
  }
}
