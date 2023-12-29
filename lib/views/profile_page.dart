import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:book_collector/views/widgets/outlined_form_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: 130,
                height: 130,
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.3),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: AppColors.primary)),
                child: const Center(
                  child: Text("USERNAME"),
                ),
              ),
              FormButton(
                onPressed: () {
                  Get.toNamed("/edit_profile");
                },
                text: "Edit Profil",
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 100),
                child: OutlinedFormTextInput(
                  labelText: "Email",
                  readOnly: true,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: logout
                },
                child: const Text(
                  "Logout Akun",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
