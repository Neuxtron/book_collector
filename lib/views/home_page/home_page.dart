import 'package:book_collector/controllers/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/page_body.dart';
import 'widgets/profile_picture.dart';
import 'widgets/search_books.dart';

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
