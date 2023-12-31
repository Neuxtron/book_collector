import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offNamed("/register");
      },
      child: const Text(
        "Buat akun baru",
        style: TextStyle(color: AppColors.primary),
      ),
    );
  }
}
