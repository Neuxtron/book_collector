import 'dart:io';

import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/action_buttons.dart';
import 'widgets/add_book_form.dart';
import 'widgets/book_image.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  BookController controller = Get.find();

  final _descriptionController = TextEditingController();
  final _isbnController = TextEditingController();
  final _titleController = TextEditingController();
  final _seriesController = TextEditingController();
  final _authorController = TextEditingController();
  final _publishedDateController = TextEditingController();
  final _publisherController = TextEditingController();
  final _pageCountController = TextEditingController();
  final _imageController = TextEditingController();
  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  String _imgUrl = "";
  String _error = "";

  Map<String, TextEditingController> get _controllers => {
        "description": _descriptionController,
        "isbn": _isbnController,
        "title": _titleController,
        "series": _seriesController,
        "author": _authorController,
        "publishedDate": _publishedDateController,
        "publisher": _publisherController,
        "pageCount": _pageCountController,
        "image": _imageController,
      };

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final formattedPublishedDate =
          DateTime.parse(_publishedDateController.text);

      final bookModel = BookModel(
        isbn: _isbnController.text,
        title: _titleController.text,
        series: _seriesController.text,
        author: _authorController.text,
        publishedDate: formattedPublishedDate,
        publisher: _publisherController.text,
        pageCount: int.parse(_pageCountController.text),
        image: _imageController.text,
        description: _descriptionController.text,
      );

      try {
        await controller.createBook(bookModel);
        Get.back();
        controller.fetchAllBooks();
      } on SocketException catch (_) {
        _scrollController.jumpTo(0);
        setState(() => _error = "Gagal terhubung ke server");
      } catch (_) {
        _scrollController.jumpTo(0);
        setState(() => _error = "Terjadi kesalahan, silahkan coba lagi");
      }
    }
  }

  void onImageChanged(url) {
    setState(() => _imgUrl = url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ActionButtons(
        controller: controller,
        onSubmit: onSubmit,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              BookImage(imgUrl: _imgUrl),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  _error,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              AddBookForm(
                controllers: _controllers,
                onImageChanged: onImageChanged,
                formKey: _formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
