import 'dart:io';

import 'package:book_collector/controllers/book_controller.dart';
import 'package:intl/intl.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:book_collector/views/widgets/outlined_form_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      bottomNavigationBar: Container(
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.network(
                    _imgUrl,
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
                            "Buku Baru",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
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

class AddBookForm extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final Function(String url) onImageChanged;
  final GlobalKey formKey;

  const AddBookForm({
    super.key,
    required this.controllers,
    required this.onImageChanged,
    required this.formKey,
  });

  @override
  State<AddBookForm> createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  void pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        widget.controllers["publishedDate"]!.text =
            DateFormat('yyyy-MM-dd').format(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: widget.controllers["description"]!,
              maxLines: 4,
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                fillColor: AppColors.primary.withAlpha(95),
                filled: true,
                hintText: "Deskripsi buku",
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 30),
            OutlinedFormTextInput(
              controller: widget.controllers["isbn"]!,
              labelText: "ISBN",
              keyboardType: TextInputType.number,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["title"]!,
              labelText: "Judul Buku",
              keyboardType: TextInputType.name,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["series"]!,
              labelText: "Series",
              keyboardType: TextInputType.name,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["author"]!,
              labelText: "Penulis",
              keyboardType: TextInputType.name,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["publishedDate"]!,
              labelText: "Tanggal Publikasi",
              readOnly: true,
              onTap: pickDate,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["publisher"]!,
              labelText: "Penerbit",
              keyboardType: TextInputType.name,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["pageCount"]!,
              labelText: "Jumlah Halaman",
              keyboardType: TextInputType.number,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["image"]!,
              labelText: "URL Gambar",
              onChanged: widget.onImageChanged,
              required: false,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
