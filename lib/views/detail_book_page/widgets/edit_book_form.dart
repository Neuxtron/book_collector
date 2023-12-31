import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/outlined_form_text_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'delete_button.dart';

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
