import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionButtons extends StatelessWidget {
  final bool isEditing;
  final Function(bool value) setEditingMode;
  final Function() onSubmit;
  final BookController controller;

  const ActionButtons({
    super.key,
    required this.isEditing,
    required this.setEditingMode,
    required this.onSubmit,
    required this.controller,
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
                if (isEditing) {
                  setEditingMode(false);
                } else {
                  Get.back();
                }
              },
              child: Text(
                isEditing ? "Batal" : "Kembali",
                style: const TextStyle(color: AppColors.primary),
              ),
            ),
          ),
          GetBuilder<BookController>(builder: (_) {
            return FormButton(
              onPressed: () {
                isEditing ? onSubmit() : setEditingMode(true);
              },
              text: isEditing ? "Simpan" : "Edit",
              minWidth: 100,
              isLoading: controller.bookStatus == BookStatus.loading,
            );
          })
        ],
      ),
    );
  }
}
