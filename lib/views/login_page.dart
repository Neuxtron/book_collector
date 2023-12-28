import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/widgets/form_text_input.dart';
import 'package:flutter/material.dart';

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
                padding: const EdgeInsets.all(40),
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  void handleLogin() {
    // TODO: handle login
    print(_emailController.text);
    print(_passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        FormTextInput(
          controller: _emailController,
          hintText: "Email",
          keyboardType: TextInputType.emailAddress,
        ),
        FormTextInput(
          controller: _passwordController,
          hintText: "Password",
          isObscure: true,
        ),
        SizedBox(height: 40),
        LoginButton(
          onPressed: handleLogin,
          isLoading: _loading,
        ),
        SizedBox(height: 15),
        SignupButton(),
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
    return MaterialButton(
      onPressed: isLoading ? null : onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      color: AppColors.primary,
      textColor: Colors.white,
      child: const Text("Masuk"),
    );
  }
}

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        "Buat akun baru",
        style: TextStyle(color: AppColors.primary),
      ),
    );
  }
}
