import 'package:book_collector/models/utils/constants/dio_api.dart';
import 'package:book_collector/utils/constants/pref_keys.dart';
import 'package:book_collector/views/auth_pages/login_page/login_page.dart';
import 'package:book_collector/views/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? _userToken;
  bool _loading = true;

  void getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString(PrefKeys.userToken) ?? "";
    DioApi.token = userToken;

    setState(() {
      _loading = false;
      _userToken = userToken;
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
    if (_userToken != null && _userToken != "") return const MainLayout();
    return const LoginPage();
  }
}
