import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'delete_dalog.dart';

class DeleteButton extends StatelessWidget {
  final int bookId;
  const DeleteButton({super.key, required this.bookId});

  void showDeleteDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteDialog(bookId: bookId);
      },
    ).then((value) {
      if (value == "deleted") Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStatePropertyAll(
            Colors.red.shade100,
          ),
          foregroundColor: const MaterialStatePropertyAll(Colors.red),
        ),
        onPressed: () => showDeleteDialog(context),
        child: const Text("Hapus buku"),
      ),
    );
  }
}
