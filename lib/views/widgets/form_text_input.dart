import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FormTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool isObscure;

  const FormTextInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isObscure,
        style: const TextStyle(fontSize: 14),
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: AppColors.inputBackground,
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
      ),
    );
  }

  InputBorder buildBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: const BorderSide(
          color: Colors.grey,
        ));
  }
}
