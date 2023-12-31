import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/outlined_form_text_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
