import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/models/source/dummy_books.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/book_list_item.dart';
import 'package:book_collector/views/home_page/widgets/book_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              Container(
                color: AppColors.primary.withOpacity(.12),
                padding: const EdgeInsets.symmetric(vertical: 20),
                margin: const EdgeInsets.only(top: 20),
                child: HorizontalBookListView(
                  title: "Favorit",
                  booksList: DummyBooks.allBooks,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: HorizontalBookListView(
                  title: "Terakhir Dilihat",
                  booksList: DummyBooks.allBooks,
                ),
              ),
              const SizedBox(height: 50),
              AllBooksListView(booksList: DummyBooks.allBooks),
            ],
          ),
        ),
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
    return const CircleAvatar();
  }
}

class HorizontalBookListView extends StatelessWidget {
  final String title;
  final List<BookModel> booksList;

  const HorizontalBookListView({
    super.key,
    required this.title,
    required this.booksList,
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
                title: book.title,
                image: book.image,
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
  const AllBooksListView({super.key, required this.booksList});

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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: booksList.length,
          itemBuilder: (context, index) {
            final book = booksList[index];
            return BookListItem(
              title: book.title,
              author: book.author,
              publishedDate: book.publishedDate,
              image: book.image,
            );
          },
        ),
      ],
    );
  }
}
