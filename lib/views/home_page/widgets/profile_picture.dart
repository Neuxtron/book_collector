import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed("/profile"),
      child: const CircleAvatar(
        backgroundImage: AssetImage("assets/images/profile.jpg"),
      ),
    );
  }
}
