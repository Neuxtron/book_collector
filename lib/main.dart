import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/views/add_book_page.dart';
import 'package:book_collector/views/login_page.dart';
import 'package:book_collector/views/main_layout.dart';
import 'package:book_collector/views/profile_page.dart';
import 'package:book_collector/views/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppColors.primary,
        ),
      ),
      initialRoute: "/main",
      routes: {
        "/": (context) => const LoginPage(),
        "/main": (context) => const MainLayout(),
        "/add_book": (context) => const AddBookPage(),
        "/profile": (context) => const ProfilePage(),
      },
    );
  }
}
