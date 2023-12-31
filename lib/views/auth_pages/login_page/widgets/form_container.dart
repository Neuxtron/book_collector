import 'package:flutter/material.dart';

import 'login_form.dart';

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
                child: Column(
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
