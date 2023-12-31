import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BookImage extends StatelessWidget {
  final String imgUrl;
  const BookImage({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.network(
          imgUrl,
          fit: BoxFit.cover,
          height: 180,
          width: 100,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 180,
              width: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(95),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Center(
                child: Text(
                  "Edit Buku",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
