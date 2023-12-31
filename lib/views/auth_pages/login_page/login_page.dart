import 'package:flutter/material.dart';

import 'widgets/bg_img.dart';
import 'widgets/form_container.dart';

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
