import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/form_text_input.dart';
import 'package:flutter/material.dart';

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
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rPasswordController = TextEditingController();
  bool _loading = false;

  void handleSignup() {
    // TODO: handle signup
    print(_emailController.text);
    print(_passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
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
        SizedBox(height: 40),
        SignupButton(
          onPressed: handleSignup,
          isLoading: _loading,
        ),
        SizedBox(height: 15),
        LoginButton(),
      ],
    );
  }
}

class SignupButton extends StatelessWidget {
  final Function() onPressed;
  final bool isLoading;

  const SignupButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 200,
      onPressed: isLoading ? null : onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      color: AppColors.primary,
      textColor: Colors.white,
      child: const Text("Daftar"),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        "Sudah punya akun",
        style: TextStyle(color: AppColors.primary),
      ),
    );
  }
}
