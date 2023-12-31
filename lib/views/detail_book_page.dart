import 'dart:io';

import 'package:book_collector/controllers/book_controller.dart';
import 'package:intl/intl.dart';
import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:book_collector/views/widgets/outlined_form_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  void toggleFavourite(value) {
    if (value) {
      // TODO: save id in localstorage
    } else {
      // TODO: remove id from localstorage
    }
  }

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

  @override
  void initState() {
    super.initState();
    setControllerTexts();
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
                  if (_isEditing) {
                    setState(() => _isEditing = false);
                  } else {
                    Get.back();
                  }
                },
                child: Text(
                  _isEditing ? "Batal" : "Kembali",
                  style: const TextStyle(color: AppColors.primary),
                ),
              ),
            ),
            GetBuilder<BookController>(builder: (_) {
              return FormButton(
                onPressed: _isEditing
                    ? onSubmit
                    : () => setState(() => _isEditing = true),
                text: _isEditing ? "Simpan" : "Edit",
                minWidth: 100,
                isLoading: _controller.bookStatus == BookStatus.loading,
              );
            })
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              PageHeader(onChange: toggleFavourite),
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
                            "Edit Buku",
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

class PageHeader extends StatefulWidget {
  final Function(bool value) onChange;
  const PageHeader({super.key, required this.onChange});

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 10),
        child: IconButton(
          onPressed: () {
            setState(() => _isFavourite = !_isFavourite);
            widget.onChange(_isFavourite);
          },
          iconSize: 40,
          icon: Icon(
            _isFavourite ? Icons.star_rounded : Icons.star_outline_rounded,
            color: AppColors.lightYelllow,
          ),
        ),
      ),
    );
  }
}

class EditBookForm extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final Function(String url) onImageChanged;
  final bool isEditing;
  final GlobalKey formKey;
  final int bookId;

  const EditBookForm({
    super.key,
    required this.controllers,
    required this.onImageChanged,
    required this.isEditing,
    required this.formKey,
    required this.bookId,
  });

  @override
  State<EditBookForm> createState() => _EditBookFormState();
}

class _EditBookFormState extends State<EditBookForm> {
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
            TextField(
              controller: widget.controllers["description"]!,
              maxLines: 4,
              cursorColor: AppColors.primary,
              readOnly: !widget.isEditing,
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
              readOnly: !widget.isEditing,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["title"]!,
              labelText: "Judul Buku",
              keyboardType: TextInputType.name,
              readOnly: !widget.isEditing,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["series"]!,
              labelText: "Series",
              keyboardType: TextInputType.name,
              readOnly: !widget.isEditing,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["author"]!,
              labelText: "Penulis",
              keyboardType: TextInputType.name,
              readOnly: !widget.isEditing,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["publishedDate"]!,
              labelText: "Tanggal Publikasi",
              readOnly: true,
              onTap: widget.isEditing ? pickDate : null,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["publisher"]!,
              labelText: "Penerbit",
              keyboardType: TextInputType.name,
              readOnly: !widget.isEditing,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["pageCount"]!,
              labelText: "Jumlah Halaman",
              keyboardType: TextInputType.number,
              readOnly: !widget.isEditing,
            ),
            OutlinedFormTextInput(
              controller: widget.controllers["image"]!,
              labelText: "URL Gambar",
              onChanged: widget.onImageChanged,
              readOnly: !widget.isEditing,
              required: false,
            ),
            DeleteButton(bookId: widget.bookId),
          ],
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  final int bookId;
  const DeleteButton({super.key, required this.bookId});

  void showDeleteDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteDialog(bookId: bookId);
      },
    );
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
      Get.back();
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
            foregroundColor: const MaterialStatePropertyAll(AppColors.primary),
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
