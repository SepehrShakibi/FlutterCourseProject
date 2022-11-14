import 'package:crypto_wallet/widgets/login_page_widget/input_text_field.dart';

import 'package:crypto_wallet/widgets/apply_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  Future<void> sendForgetPasswordEmail() async {
    final navigator = Navigator.pop(context);

    try {
      if (_emailController.text.trim().isNotEmpty) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        navigator;
      } else {
        var snackBar = const SnackBar(
            backgroundColor: Color.fromARGB(255, 28, 28, 28),
            content: Text(
              'Please Enter Email',
              style: TextStyle(fontFamily: 'RobotoR'),
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      var snackBar = const SnackBar(
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
          content: Text(
            'Sorry...There is a problem!Please try again..',
            style: TextStyle(fontFamily: 'RobotoR'),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        //   backgroundColor: KbackgroundColor,
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/forget_background.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.4)),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Enter your Email",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: 'CharisSILB',
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.8,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputTextField(
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'CryptoWallet@email.com',
                      prefixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ApplyButton(
                      width: size.width,
                      size: size,
                      onTap: sendForgetPasswordEmail,
                      color: Colors.white.withOpacity(0.4),
                      text: 'Send Email',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
