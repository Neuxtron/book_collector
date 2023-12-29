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
  final _descriptionController = TextEditingController();
  final _isbnController = TextEditingController();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _publishedDateController = TextEditingController();
  final _publisherController = TextEditingController();
  final _pageCountController = TextEditingController();
  final _imageController = TextEditingController();

  String _imgUrl = "";
  bool _isEditing = false;

  Map<String, TextEditingController> get _controllers => {
        "description": _descriptionController,
        "isbn": _isbnController,
        "title": _titleController,
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

  void onSubmit() {
    final formattedPublishedDate =
        DateTime.parse(_publishedDateController.text);

    final bookModel = BookModel(
      isbn: _isbnController.text,
      title: _titleController.text,
      author: _authorController.text,
      publishedDate: formattedPublishedDate,
      publisher: _publisherController.text,
      pageCount: int.parse(_pageCountController.text),
      image: _imageController.text,
    );

    // TODO: upload to api
    print(bookModel);
  }

  void onImageChanged(url) {
    setState(() => _imgUrl = url);
  }

  void setControllerTexts() {
    _isbnController.text = widget.bookModel.isbn;
    _titleController.text = widget.bookModel.title;
    _authorController.text = widget.bookModel.author;
    _publishedDateController.text = widget.bookModel.publishedDate.toString();
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
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: TextButton(
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
              FormButton(
                onPressed: _isEditing
                    ? onSubmit
                    : () => setState(() => _isEditing = true),
                text: _isEditing ? "Simpan" : "Edit",
                minWidth: 100,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              PageHeader(onChange: toggleFavourite),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: _imgUrl == ""
                    ? Container(
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
                        ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.network(
                          _imgUrl,
                          fit: BoxFit.cover,
                          height: 180,
                          width: 100,
                        ),
                      ),
              ),
              AddBookForm(
                controllers: _controllers,
                onImageChanged: onImageChanged,
                isEditing: _isEditing,
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

class AddBookForm extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final Function(String url) onImageChanged;
  final bool isEditing;

  const AddBookForm({
    super.key,
    required this.controllers,
    required this.onImageChanged,
    required this.isEditing,
  });

  @override
  State<AddBookForm> createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            controller: widget.controllers["author"]!,
            labelText: "Penulis",
            keyboardType: TextInputType.name,
            readOnly: !widget.isEditing,
          ),
          // TODO: use date picker
          OutlinedFormTextInput(
            controller: widget.controllers["publishedDate"]!,
            labelText: "Tanggal Publikasi",
            readOnly: !widget.isEditing,
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
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
