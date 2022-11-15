import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/constants/route.dart';
import 'package:crypto_wallet/helpers/loading/loading_screen.dart';
import 'package:crypto_wallet/model/provider_model.dart';
import 'package:crypto_wallet/widgets/login_page_widget/input_text_field.dart';
import 'package:crypto_wallet/widgets/login_page_widget/password_text_field.dart';
import 'package:crypto_wallet/widgets/apply_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onTap;

  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // ignore: non_constant_identifier_names
  void Login(BuildContext context) async {
    final provider = Provider.of<ModelProvider>(context, listen: false);
    try {
      if (_emailController.text.trim().isNotEmpty &
          _passwordController.text.trim().isNotEmpty) {
        LoadingScreen().show(context: context, text: 'Please wait a moment...');
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        await provider.initialBlance();
        await provider.initialTransaction();
        await provider.setPriceOnline();
        await provider.setCharts();
        //  provider.resetLocalTransacion();
      } else {
        LoadingScreen().hide();
        var snackBar = const SnackBar(
            backgroundColor: Color.fromARGB(255, 28, 28, 28),
            content: Text(
              'Please Complete Data',
              style: TextStyle(fontFamily: 'RobotoR'),
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      LoadingScreen().hide();
      var snackBar = const SnackBar(
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
          content: Text(
            'Sorry...There is a problem!Please try again..',
            style: TextStyle(fontFamily: 'RobotoR'),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<ModelProvider>(context).resetLocalTransacion();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/register_background.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.4)),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: size.height / 2.1,
                      width: size.height / 30,
                      child: Lottie.asset("assets/animations/xW5sHdHxwE.json"),
                    ),
                    SizedBox(
                      height: size.height / 200,
                    ),
                    const Text(
                      "Welcome to \nCrypto Wallet App",
                      style: TextStyle(
                          fontFamily: 'BebasNeueR',
                          color: Colors.white,
                          fontSize: 45),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputTextField(
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      hintText: "CryptoWallet@email.Com",
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PasswordTextField(
                      controller: _passwordController,
                      prefixIcon: Icons.password_outlined,
                      hintText: 'Your Strong Password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, forgetPasswordPage),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KsuboptionColor,
                              fontSize: 13,
                              fontFamily: 'CharisSILB'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ApplyButton(
                      width: size.width,
                      text: 'Login',
                      size: size,
                      onTap: () => Login(context),
                      color: KButtonBackgroundColor1.withOpacity(0.9),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Not Member? ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'CharisSILB'),
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text("Register Now!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: KsuboptionColor,
                                  fontSize: 14,
                                  fontFamily: 'CharisSILB')),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
