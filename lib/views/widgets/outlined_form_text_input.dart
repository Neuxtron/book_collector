import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

class OutlinedFormTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final TextInputType? keyboardType;
  final Function(String value)? onChanged;
  final bool readOnly;

  const OutlinedFormTextInput({
    super.key,
    this.controller,
    required this.labelText,
    this.keyboardType,
    this.onChanged,
    this.readOnly = false,
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
        readOnly: readOnly,
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
