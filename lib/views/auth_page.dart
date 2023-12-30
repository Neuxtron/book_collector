import 'package:book_collector/utils/constants/pref_keys.dart';
import 'package:book_collector/views/login_page.dart';
import 'package:book_collector/views/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? _userEmail;
  bool _loading = true;

  void getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString(PrefKeys.userEmail) ?? "";
    setState(() {
      _loading = false;
      _userEmail = userEmail;
    });
  }

  @override
  void initState() {
    super.initState();
    getSavedUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold();
    if (_userEmail != null && _userEmail != "") return const MainLayout();
    return const LoginPage();
  }
}
