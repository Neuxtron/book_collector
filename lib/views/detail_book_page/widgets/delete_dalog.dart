import 'dart:io';

import 'package:book_collector/controllers/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'delete_actions.dart';

class DeleteDialog extends StatefulWidget {
  final int bookId;
  const DeleteDialog({super.key, required this.bookId});

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  BookController controller = BookController();
  bool get _isFailed => controller.bookStatus == BookStatus.failed;
  String _error = "";

  void onDelete() async {
    try {
      await controller.deleteBook(widget.bookId);
      Get.back(result: "deleted");
      controller.fetchAllBooks();
    } on SocketException catch (_) {
      setState(() => _error = "Gagal terhubung ke server");
    } catch (e) {
      setState(() => _error = "Terjadi kesalahan, silahkan coba lagi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Apakah Anda ingi menghapus buku ini?",
            textAlign: TextAlign.center,
          ),
          GetBuilder<BookController>(
            builder: (_) {
              if (controller.bookStatus == BookStatus.failed) {
                return Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    _error,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
      actionsPadding: const EdgeInsets.all(20),
      actions: [
        DeleteActions(
          onDelete: onDelete,
        )
      ],
    );
  }
}
