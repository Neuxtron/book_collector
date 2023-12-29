import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:book_collector/views/widgets/outlined_form_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              UsernameView(),
              ProfileForm(),
              ActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class UsernameView extends StatelessWidget {
  const UsernameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20, bottom: 50),
      child: Column(
        children: [
          OutlinedFormTextInput(
            labelText: "Nama Lengkap",
            readOnly: true,
          ),
          OutlinedFormTextInput(
            labelText: "Email",
            readOnly: true,
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 100,
          child: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Batal",
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ),
        FormButton(
          onPressed: () {},
          text: "Simpan",
          minWidth: 100,
        ),
      ],
    );
  }
}
