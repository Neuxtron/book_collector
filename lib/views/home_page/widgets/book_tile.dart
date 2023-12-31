import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
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
        Get.to(() => DetailBookPage(bookModel: model));
      },
      child: Container(
        height: 200,
        width: 130,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  model.image,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 110,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(95),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          model.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(model.title),
          ],
        ),
      ),
    );
  }
}
