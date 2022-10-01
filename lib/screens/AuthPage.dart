import 'package:crypto_wallet/screens/login_page.dart';
import 'package:crypto_wallet/screens/register_page.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool ShowLoginPage = true;
  void ToggleScreen() {
    setState(() {
      ShowLoginPage = !ShowLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ShowLoginPage) {
      return LoginPage(
        onTap: ToggleScreen,
      );
    } else {
      return RegisterPage(onTap: ToggleScreen);
    }
  }
}
