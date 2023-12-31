import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionButtons extends StatelessWidget {
  final BookController controller;
  final Function() onSubmit;

  const ActionButtons({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStatePropertyAll(
                  AppColors.primary.withOpacity(.1),
                ),
              ),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Kembali",
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ),
          GetBuilder<BookController>(builder: (_) {
            return FormButton(
              onPressed: onSubmit,
              text: "Simpan",
              minWidth: 100,
              isLoading: controller.bookStatus == BookStatus.loading,
            );
          }),
        ],
      ),
    );
  }
}
