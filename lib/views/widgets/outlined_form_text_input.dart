import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

class OutlinedFormTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final TextInputType? keyboardType;
  final Function(String value)? onChanged;
  final bool readOnly;
  final Function()? onTap;
  final bool required;

  const OutlinedFormTextInput({
    super.key,
    this.controller,
    required this.labelText,
    this.keyboardType,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.required = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.primary,
        keyboardType: keyboardType,
        onChanged: onChanged,
        readOnly: readOnly,
        onTap: onTap,
        validator: (value) {
          if (required && (value == null || value.isEmpty)) {
            return "Isian tidak boleh kosong";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelStyle: const TextStyle(color: AppColors.primary),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
          errorBorder: buildBorder(),
          focusedErrorBorder: buildBorder(),
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
