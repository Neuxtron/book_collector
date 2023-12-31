import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/utils/constants/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'horizontal_books_list_view.dart';

class FavouritesSection extends StatefulWidget {
  final List<BookModel> booksList;
  const FavouritesSection({super.key, required this.booksList});

  @override
  State<FavouritesSection> createState() => _FavouritesSectionState();
}

class _FavouritesSectionState extends State<FavouritesSection> {
  List<int> _favouriteIds = [];
  List<BookModel> get _favouriteBooks {
    List<BookModel> favouriteBooks = [];
    for (var id in _favouriteIds) {
      final book = widget.booksList.firstWhereOrNull((book) {
        return book.id == id;
      });
      if (book != null) favouriteBooks.add(book);
    }
    return favouriteBooks;
  }

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
    if (_favouriteBooks.isEmpty) return const SizedBox();

    return Container(
      color: AppColors.primary.withOpacity(.12),
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.only(top: 20),
      child: HorizontalBookListView(
        title: "Favorit",
        booksList: _favouriteBooks,
        onBack: (value) => getFavouriteIds(),
      ),
    );
  }
}
