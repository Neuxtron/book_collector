import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookTile extends StatelessWidget {
  final BookModel model;

  const BookTile({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(DetailBookPage(bookModel: model));
      },
      child: Container(
        height: 200,
        width: 130,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(model.image),
              ),
            ),
            SizedBox(height: 10),
            Text(model.title),
          ],
        ),
      ),
    );
  }
}
