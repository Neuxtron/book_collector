import 'package:book_collector/models/book_model.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _descriptionController = TextEditingController();
  final _isbnController = TextEditingController();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _publishedDateController = TextEditingController();
  final _publisherController = TextEditingController();
  final _pageCountController = TextEditingController();
  final _imageController = TextEditingController();

  String _imgUrl = "";

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
                    Get.back();
                  },
                  child: const Text(
                    "Kembali",
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
              FormButton(
                onPressed: onSubmit,
                text: "Simpan",
                minWidth: 100,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // PageHeadear(onChange: (value) => isFavourite = value),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: remove
class PageHeadear extends StatefulWidget {
  final Function(bool value) onChange;
  const PageHeadear({super.key, required this.onChange});

  @override
  State<PageHeadear> createState() => _PageHeadearState();
}

class _PageHeadearState extends State<PageHeadear> {
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          IconButton(
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
        ],
      ),
    );
  }
}

class AddBookForm extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final Function(String url) onImageChanged;

  const AddBookForm({
    super.key,
    required this.controllers,
    required this.onImageChanged,
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
          InputItem(
            controller: widget.controllers["isbn"]!,
            labelText: "ISBN",
            keyboardType: TextInputType.number,
          ),
          InputItem(
            controller: widget.controllers["title"]!,
            labelText: "Judul Buku",
            keyboardType: TextInputType.name,
          ),
          InputItem(
            controller: widget.controllers["author"]!,
            labelText: "Penulis",
            keyboardType: TextInputType.name,
          ),
          InputItem(
            controller: widget.controllers["publishedDate"]!,
            labelText: "Tanggal Publikasi",
          ),
          InputItem(
            controller: widget.controllers["publisher"]!,
            labelText: "Penerbit",
            keyboardType: TextInputType.name,
          ),
          InputItem(
            controller: widget.controllers["pageCount"]!,
            labelText: "Jumlah Halaman",
            keyboardType: TextInputType.number,
          ),
          InputItem(
            controller: widget.controllers["image"]!,
            labelText: "URL Gambar",
            onChanged: widget.onImageChanged,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class InputItem extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final Function(String value)? onChanged;

  const InputItem({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        cursorColor: AppColors.primary,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelStyle: const TextStyle(color: AppColors.primary),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
      ),
    );
  }

  InputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primary),
      borderRadius: BorderRadius.circular(7),
    );
  }
}
