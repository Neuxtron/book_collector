import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

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
