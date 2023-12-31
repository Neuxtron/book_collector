import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offNamed("/login");
      },
      child: const Text(
        "Sudah punya akun",
        style: TextStyle(color: AppColors.primary),
      ),
    );
  }
}
