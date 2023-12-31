import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SearchBooks extends StatelessWidget {
  final Function(String) onChanged;
  const SearchBooks({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        cursorColor: AppColors.primary,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: const Icon(Icons.search_rounded),
          prefixIconColor: Colors.grey,
          fillColor: AppColors.inputBackground,
          filled: true,
          isDense: true,
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
      ),
    );
  }

  InputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide.none,
    );
  }
}
