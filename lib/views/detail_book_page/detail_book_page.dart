import 'dart:io';

import 'package:book_collector/controllers/book_controller.dart';
import 'package:book_collector/utils/constants/pref_keys.dart';
import 'package:intl/intl.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/action_buttons.dart';
import 'widgets/book_image.dart';
import 'widgets/edit_book_form.dart';
import 'widgets/page_header.dart';

class DetailBookPage extends StatefulWidget {
  final BookModel bookModel;
  const DetailBookPage({super.key, required this.bookModel});

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookController _controller = Get.find();

  final _descriptionController = TextEditingController();
  final _isbnController = TextEditingController();
  final _titleController = TextEditingController();
  final _seriesController = TextEditingController();
  final _authorController = TextEditingController();
  final _publishedDateController = TextEditingController();
  final _publisherController = TextEditingController();
  final _pageCountController = TextEditingController();
  final _imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  String _imgUrl = "";
  bool _isEditing = false;
  String _error = "Tekan edit untuk mulai edit";
  String _errorType = "warning";

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
        id: widget.bookModel.id,
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
        await _controller.editBook(bookModel);
        Get.back();
        _controller.fetchAllBooks();
      } on SocketException catch (_) {
        _scrollController.jumpTo(0);
        _errorType = "error";
        setState(() => _error = "Gagal terhubung ke server");
      } catch (_) {
        _errorType = "error";
        _scrollController.jumpTo(0);
        setState(() => _error = "Terjadi kesalahan, silahkan coba lagi");
      }
    }
  }

  void onImageChanged(url) {
    setState(() => _imgUrl = url);
  }

  void setControllerTexts() {
    final publishedDate = widget.bookModel.publishedDate;
    final formattedPublishedDate =
        DateFormat('yyyy-MM-dd').format(publishedDate);

    _isbnController.text = widget.bookModel.isbn;
    _titleController.text = widget.bookModel.title;
    _seriesController.text = widget.bookModel.series;
    _authorController.text = widget.bookModel.author;
    _publishedDateController.text = formattedPublishedDate;
    _publisherController.text = widget.bookModel.publisher;
    _pageCountController.text = widget.bookModel.pageCount.toString();
    _imageController.text = widget.bookModel.image;

    _imgUrl = _imageController.text;
  }

  void updateHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final rawIds = prefs.getStringList(PrefKeys.recentIds) ?? [];
    List<int> ids = rawIds.map((e) => int.tryParse(e) ?? -1).toList();

    int id = widget.bookModel.id!;
    ids.removeWhere((id) => id == widget.bookModel.id);
    ids.insert(0, id);

    final stringIds = ids.map((e) => e.toString()).toList();
    prefs.setStringList(PrefKeys.recentIds, stringIds);
  }

  @override
  void initState() {
    super.initState();
    setControllerTexts();
    updateHistory();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _isbnController.dispose();
    _titleController.dispose();
    _seriesController.dispose();
    _authorController.dispose();
    _publishedDateController.dispose();
    _publisherController.dispose();
    _pageCountController.dispose();
    _imageController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ActionButtons(
        controller: _controller,
        isEditing: _isEditing,
        onSubmit: onSubmit,
        setEditingMode: (value) => setState(() => _isEditing = value),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              PageHeader(bookId: widget.bookModel.id!),
              BookImage(imgUrl: _imgUrl),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  _error,
                  style: TextStyle(
                    color: _errorType == "warning"
                        ? Colors.yellow.shade700
                        : Colors.red,
                  ),
                ),
              ),
              EditBookForm(
                controllers: _controllers,
                onImageChanged: onImageChanged,
                isEditing: _isEditing,
                formKey: _formKey,
                bookId: widget.bookModel.id!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
