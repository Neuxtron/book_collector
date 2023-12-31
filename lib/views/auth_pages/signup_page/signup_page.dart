import 'package:flutter/material.dart';

import 'widgets/bg_img.dart';
import 'widgets/form_container.dart';

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
