import 'package:flutter/material.dart';

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
