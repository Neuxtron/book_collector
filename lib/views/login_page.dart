import 'dart:io';

import 'package:book_collector/controllers/login_controller.dart';
import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/form_button.dart';
import 'package:book_collector/views/widgets/form_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80, bottom: 40),
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
                      "Masuk",
                      style: TextStyle(fontSize: 22),
                    ),
                    LoginForm(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  UserController controller = Get.find();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool get _loading => controller.userStatus == UserStatus.loading;
  String _error = "";

  void handleLogin() async {
    setState(() => _error = "");
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      await controller.login(email, password);
      Get.offNamed("/main");
    } on SocketException catch (_) {
      setState(() => _error = "Gagal terhubung ke server");
    } on UnauthorizedException catch (_) {
      setState(() => _error = "Email atau password salah");
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
          controller: _emailController,
          hintText: "Email",
          keyboardType: TextInputType.emailAddress,
        ),
        FormTextInput(
          controller: _passwordController,
          hintText: "Kata Sandi",
          isObscure: true,
        ),
        const SizedBox(height: 40),
        GetBuilder<UserController>(builder: (_) {
          return LoginButton(
            onPressed: handleLogin,
            isLoading: _loading,
          );
        }),
        const SizedBox(height: 15),
        const SignupButton(),
      ],
    );
  }
}

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
