import 'package:flutter/material.dart';

import 'signup_form.dart';

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
