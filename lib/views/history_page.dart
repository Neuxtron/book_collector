import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/pref_keys.dart';
import 'package:book_collector/views/widgets/books_list_view.dart';
import 'package:book_collector/views/widgets/error_builder.dart';
import 'package:book_collector/views/widgets/loading_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  BookController controller = Get.find();
  List<int> _recentIds = [];

  void getRecentIds() async {
    final prefs = await SharedPreferences.getInstance();
    final rawIds = prefs.getStringList(PrefKeys.recentIds) ?? [];
    final ids = rawIds.map((e) => int.tryParse(e) ?? -1).toList();
    setState(() => _recentIds = ids);
  }

  @override
  void initState() {
    super.initState();
    getRecentIds();
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
                  Icons.history_rounded,
                  size: 30,
                  color: Colors.blueGrey.shade700.withOpacity(.5),
                ),
                const SizedBox(width: 10),
                Text(
                  "Riwayat",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.blueGrey.shade700.withOpacity(.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Obx(
            () {
              final booksList = controller.booksList;
              if (controller.bookStatus == BookStatus.loading) {
                return const LoadingBuilder();
              }
              if (controller.bookStatus == BookStatus.failed) {
                return const ErrorBuilder();
              }
              List<BookModel> recentBooks = [];
              for (var id in _recentIds) {
                final book = booksList.firstWhereOrNull((book) {
                  return book.id == id;
                });
                if (book != null) recentBooks.add(book);
              }

              if (recentBooks.isEmpty) {
                return const Center(
                  child: Text("Riwayat Anda masih kosong"),
                );
              }
              return BooksListView(
                booksList: recentBooks,
                onBack: (value) => getRecentIds(),
              );
            },
          )
        ],
      ),
    );
  }
}
