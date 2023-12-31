import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/utils/constants/pref_keys.dart';
import 'package:book_collector/views/home_page/widgets/book_tile.dart';
import 'package:book_collector/views/widgets/books_list_view.dart';
import 'package:book_collector/views/widgets/error_builder.dart';
import 'package:book_collector/views/widgets/loading_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    BookController controller = Get.find();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/add_book");
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  SearchBooks(),
                  SizedBox(width: 20),
                  ProfilePicture(),
                ],
              ),
            ),
            PageBody(bookController: controller),
          ],
        ),
      ),
    );
  }
}

class PageBody extends StatefulWidget {
  final BookController bookController;

  const PageBody({
    super.key,
    required this.bookController,
  });

  @override
  State<PageBody> createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  @override
  Widget build(BuildContext context) {
    widget.bookController.fetchAllBooks();
    return GetBuilder<BookController>(builder: (_) {
      final bookStatus = widget.bookController.bookStatus;

      if (bookStatus == BookStatus.loading) return const LoadingBuilder();
      if (bookStatus == BookStatus.failed &&
          widget.bookController.booksList.isEmpty) {
        return const ErrorBuilder();
      }

      return Obx(() => Column(
            children: [
              FavouritesSection(booksList: widget.bookController.booksList),
              RecentsSections(booksList: widget.bookController.booksList),
              const SizedBox(height: 50),
              AllBooksListView(
                booksList: widget.bookController.booksList,
                onBack: (value) => setState(() {}),
              ),
            ],
          ));
    });
  }
}

class FavouritesSection extends StatefulWidget {
  final List<BookModel> booksList;
  const FavouritesSection({super.key, required this.booksList});

  @override
  State<FavouritesSection> createState() => _FavouritesSectionState();
}

class _FavouritesSectionState extends State<FavouritesSection> {
  List<int> _favouriteIds = [];
  List<BookModel> get _favouriteBooks {
    return widget.booksList
        .where((book) => _favouriteIds.contains(book.id))
        .toList();
  }

  void getFavouriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final rawIds = prefs.getStringList(PrefKeys.favouriteIds) ?? [];
    final ids = rawIds.map((e) => int.tryParse(e) ?? -1).toList();
    setState(() => _favouriteIds = ids);
  }

  @override
  Widget build(BuildContext context) {
    getFavouriteIds();
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

class SearchBooks extends StatelessWidget {
  const SearchBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: const Icon(Icons.search_rounded),
          prefixIconColor: Colors.grey,
          fillColor: AppColors.inputBackground,
          filled: true,
          isDense: true,
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
      ),
    );
  }

  InputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide.none,
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed("/profile"),
      child: const CircleAvatar(
        backgroundImage: AssetImage("assets/images/profile.jpg"),
      ),
    );
  }
}

class HorizontalBookListView extends StatelessWidget {
  final String title;
  final List<BookModel> booksList;
  final Function(dynamic value) onBack;

  const HorizontalBookListView({
    super.key,
    required this.title,
    required this.booksList,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 21,
              color: Colors.black.withOpacity(.18),
              fontWeight: FontWeight.bold,
              // IDEA: font family to arial rounded
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: booksList.length,
            itemBuilder: (context, index) {
              final book = booksList[index];
              return BookTile(
                model: book,
                onBack: onBack,
              );
            },
          ),
        ),
      ],
    );
  }
}

class AllBooksListView extends StatelessWidget {
  final List<BookModel> booksList;
  final Function(dynamic value) onBack;

  const AllBooksListView({
    super.key,
    required this.booksList,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
          child: Text(
            "Buku Anda",
            style: TextStyle(
              fontSize: 21,
              color: Colors.black.withOpacity(.18),
              fontWeight: FontWeight.bold,
              // IDEA: font family to arial rounded
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: BooksListView(
            booksList: booksList,
            onBack: onBack,
          ),
        )
      ],
    );
  }
}
