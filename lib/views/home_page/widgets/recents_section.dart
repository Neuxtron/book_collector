import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'horizontal_books_list_view.dart';

class RecentsSections extends StatefulWidget {
  final List<BookModel> booksList;
  const RecentsSections({super.key, required this.booksList});

  @override
  State<RecentsSections> createState() => _RecentsSectionsState();
}

class _RecentsSectionsState extends State<RecentsSections> {
  List<int> _recentIds = [];
  List<BookModel> get _recentBooks {
    return _recentIds.map((id) {
      return widget.booksList.firstWhere((book) {
        return book.id == id;
      });
    }).toList();
  }

  void getRecentIds() async {
    final prefs = await SharedPreferences.getInstance();
    final rawIds = prefs.getStringList(PrefKeys.recentIds) ?? [];
    final ids = rawIds.map((e) => int.tryParse(e) ?? -1).toList();
    setState(() => _recentIds = ids);
  }

  @override
  Widget build(BuildContext context) {
    getRecentIds();
    if (_recentBooks.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: HorizontalBookListView(
        title: "Terakhir Dilihat",
        booksList: _recentBooks,
        onBack: (value) => getRecentIds(),
      ),
    );
  }
}
