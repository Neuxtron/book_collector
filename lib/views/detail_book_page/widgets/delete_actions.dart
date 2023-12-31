import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteActions extends StatelessWidget {
  final Function() onDelete;

  const DeleteActions({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStatePropertyAll(
              AppColors.primary.withOpacity(.1),
            ),
            foregroundColor: const MaterialStatePropertyAll(
              AppColors.primary,
            ),
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text("Batal"),
        ),
        GetBuilder<BookController>(builder: (_) {
          return FormButton(
            onPressed: onDelete,
            text: "Hapus",
            color: Colors.red,
          );
        })
      ],
    );
  }
}
