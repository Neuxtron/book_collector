import 'dart:io';

import 'package:book_collector/controllers/user_controller.dart';
import 'package:book_collector/views/widgets/form_text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

import 'login_button.dart';
import 'signup_button.dart';

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
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    controller.dispose();
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
