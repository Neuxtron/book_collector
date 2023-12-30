import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookListItem extends StatelessWidget {
  final BookModel model;

  const BookListItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final formattedPublishedDate =
        DateFormat('dd MMM yyyy').format(model.publishedDate);

    return InkWell(
      onTap: () {
        Get.to(DetailBookPage(bookModel: model));
      },
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(.18),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                model.image,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(95),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Text(
                        model.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.title),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "${model.author} • $formattedPublishedDate",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
