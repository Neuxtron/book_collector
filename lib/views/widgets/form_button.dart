import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final Function() onPressed;
  final bool isLoading;
  final String text;
  final double? minWidth;

  const FormButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      onPressed: !isLoading ? onPressed : null,
      color: AppColors.primary,
      disabledColor: AppColors.primary.withOpacity(.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      textColor: Colors.white,
      child: !isLoading
          ? Text(text)
          : const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ),
            ),
    );
  }
}
