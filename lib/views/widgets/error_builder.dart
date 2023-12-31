import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorBuilder extends StatelessWidget {
  const ErrorBuilder({super.key});

  void retry() {
    BookController controller = Get.find();
    controller.fetchAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 70, bottom: 10),
            child: Text("Gagal mengambil data buku"),
          ),
          FormButton(
            onPressed: retry,
            text: "Coba lagi",
          ),
        ],
      ),
    );
  }
}
