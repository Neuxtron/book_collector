import 'dart:io';

import 'package:book_collector/controllers/login_controller.dart';
import 'package:book_collector/models/utils/constants/app_exceptions.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:book_collector/views/widgets/form_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          BgImage(),
          FormContainer(),
        ],
      ),
    );
  }
}

class BgImage extends StatelessWidget {
  const BgImage({super.key});

  // OPTIMIZE: make background static
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/login_bg.jpg",
      fit: BoxFit.cover,
      height: double.infinity,
      color: Colors.black54,
      colorBlendMode: BlendMode.darken,
    );
  }
}

class FormContainer extends StatelessWidget {
  const FormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 40),
              child: Image.asset(
                "assets/images/logo.png",
                width: 130,
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Column(
                    children: [
                      Text(
                        "Daftar Akun Baru",
                        style: TextStyle(fontSize: 22),
                      ),
                      SignupForm(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  UserController controller = Get.find();

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rPasswordController = TextEditingController();

  bool get _loading => controller.userStatus == UserStatus.loading;
  String _error = "";

  void handleSignup() async {
    setState(() => _error = "");
    final name = _emailController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final rPassword = _rPasswordController.text;

    if (password.length < 8) {
      setState(() => _error = "Kata sandi minimal 8 karakter");
      return;
    }
    if (password != rPassword) {
      setState(() => _error = "Kedua kata sandi tidak sama");
      return;
    }

    try {
      await controller.signup(name, email, password);
      Get.offNamed("/main");
    } on SocketException catch (_) {
      setState(() => _error = "Gagal terhubung ke server");
    } on BadRequestException catch (_) {
      setState(() => _error = "Email sudah terdaftar");
    } catch (_) {
      setState(() => _error = "Terjadi kesalahan, silahkan coba lagi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            _error,
            style: const TextStyle(color: Colors.red),
          ),
        ),
        FormTextInput(
          controller: _nameController,
          hintText: "Nama Lengkap",
          keyboardType: TextInputType.name,
        ),
        FormTextInput(
          controller: _emailController,
          hintText: "Email",
          keyboardType: TextInputType.emailAddress,
        ),
        FormTextInput(
          controller: _passwordController,
          hintText: "Kata Sandi",
          isObscure: true,
        ),
        FormTextInput(
          controller: _rPasswordController,
          hintText: "Ulangi Kata Sandi",
          isObscure: true,
        ),
        const SizedBox(height: 40),
        GetBuilder<UserController>(builder: (_) {
          return FormButton(
            onPressed: handleSignup,
            isLoading: _loading,
            text: "Daftar",
            minWidth: 200,
          );
        }),
        const SizedBox(height: 15),
        const LoginButton(),
      ],
    );
  }
}

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
