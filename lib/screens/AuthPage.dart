import 'package:crypto_wallet/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:crypto_wallet/screens/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;
  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: toggleScreen,
      );
    } else {
      return RegisterPage(onTap: toggleScreen);
    }
  }
}
