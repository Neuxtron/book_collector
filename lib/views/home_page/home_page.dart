import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/home_page/widgets/book_tile.dart';
import 'package:book_collector/views/widgets/books_list_view.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          Get.toNamed("/add_book")?.then((value) => controller.fetchAllBooks());
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

class PageBody extends StatelessWidget {
  final BookController bookController;
  const PageBody({super.key, required this.bookController});

  @override
  Widget build(BuildContext context) {
    bookController.fetchAllBooks();
    return GetBuilder<BookController>(builder: (_) {
      final bookStatus = bookController.bookStatus;

      if (bookStatus == BookStatus.loading) return const LoadingBuilder();
      if (bookStatus == BookStatus.failed && bookController.booksList.isEmpty) {
        return ErrorBuilder(tryAgain: bookController.fetchAllBooks);
      }

      return Obx(() => Column(
            children: [
              // TODO: favourites list
              // Container(
              //   color: AppColors.primary.withOpacity(.12),
              //   padding: const EdgeInsets.symmetric(vertical: 20),
              //   margin: const EdgeInsets.only(top: 20),
              //   child: HorizontalBookListView(
              //     title: "Favorit",
              //     booksList: bookController.booksList,
              //   ),
              // ),
              // TODO: recents list
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: HorizontalBookListView(
              //     title: "Terakhir Dilihat",
              //     booksList: bookController.booksList,
              //   ),
              // ),
              // const SizedBox(height: 50),
              AllBooksListView(booksList: bookController.booksList),
            ],
          ));
    });
  }
}

class LoadingBuilder extends StatelessWidget {
  const LoadingBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class ErrorBuilder extends StatelessWidget {
  final Function() tryAgain;
  const ErrorBuilder({super.key, required this.tryAgain});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 70, bottom: 10),
            child: Text("Gagal mengambil data buku"),
          ),
          FormButton(
            onPressed: tryAgain,
            text: "Coba lagi",
          ),
        ],
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
                model: book,
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
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: BooksListView(booksList: booksList),
        )
      ],
    );
  }
}
