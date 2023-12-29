import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final Function() onPressed;
  final bool enabled;
  final String text;
  final double? minWidth;

  const FormButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.enabled = true,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      onPressed: enabled ? onPressed : null,
      color: AppColors.primary,
      disabledColor: AppColors.primary.withOpacity(.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      textColor: Colors.white,
      child: Text(text),
    );
  }
}
