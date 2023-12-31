import 'package:book_collector/views/widgets/form_button.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function() onPressed;
  final bool isLoading;

  const LoginButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return FormButton(
      onPressed: onPressed,
      text: "Masuk",
      minWidth: 200,
      isLoading: isLoading,
    );
  }
}
