import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorBuilder extends StatefulWidget {
  const ErrorBuilder({super.key});

  @override
  State<ErrorBuilder> createState() => _ErrorBuilderState();
}

class _ErrorBuilderState extends State<ErrorBuilder> {
  final BookController _controller = Get.find();
  bool _isLoading = false;

  void retry() async {
    setState(() => _isLoading = true);
    try {
      await _controller.fetchAllBooks();
      setState(() => _isLoading = false);
    } catch (_) {
      setState(() => _isLoading = false);
    }
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
          GetBuilder<BookController>(builder: (_) {
            return FormButton(
              onPressed: retry,
              text: "Coba lagi",
              isLoading: _isLoading,
            );
          }),
        ],
      ),
    );
  }
}
