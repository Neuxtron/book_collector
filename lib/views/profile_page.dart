import 'package:book_collector/controllers/user_controller.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/utils/constants/pref_keys.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:book_collector/views/widgets/outlined_form_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void handleLogout(UserController controller) async {
    final prefs = await SharedPreferences.getInstance();
    controller.logout();
    prefs.setString(PrefKeys.userToken, "");
    Get.offAllNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    UserController controller = Get.find();

    return Scaffold(
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
      body: SafeArea(
        child: Padding(
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
                style: ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(
                    AppColors.primary.withOpacity(.1),
                  ),
                ),
                onPressed: () => handleLogout(controller),
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
