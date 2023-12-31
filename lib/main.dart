import 'package:book_collector/utils/constants/app_colors.dart';
import 'package:book_collector/utils/helpers/init_dependencies.dart';
import 'package:book_collector/views/add_book_page.dart';
import 'package:book_collector/views/auth_pages/auth_page.dart';
import 'package:book_collector/views/edit_profile.dart';
import 'package:book_collector/views/auth_pages/login_page/login_page.dart';
import 'package:book_collector/views/layouts/main_layout.dart';
import 'package:book_collector/views/profile_page.dart';
import 'package:book_collector/views/auth_pages/signup_page/signup_page.dart';
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
      initialBinding: InitDep(),
      initialRoute: "/",
      routes: {
        "/": (context) => const AuthPage(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const SignupPage(),
        "/main": (context) => const MainLayout(),
        "/add_book": (context) => const AddBookPage(),
        "/profile": (context) => const ProfilePage(),
        "/edit_profile": (context) => const EditProfilePage(),
      },
    );
  }
}
