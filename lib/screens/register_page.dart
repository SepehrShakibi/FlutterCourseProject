// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/helpers/loading/loading_screen.dart';
import 'package:crypto_wallet/model/provider_model.dart';

import 'package:crypto_wallet/widgets/register_page_widget/password/registerpage_password_listtile.dart';
import 'package:crypto_wallet/widgets/apply_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/register_page_widget/input/registerpage_input_listtile.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  bool PasswordConfirm() {
    if (_firstnameController.text.trim().isEmpty ||
        _lastnameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _repeatPasswordController.text.trim().isEmpty) {
      var snackBar = const SnackBar(
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
          content: Text(
            'Please Complete fields',
            style: TextStyle(fontFamily: 'RobotoR'),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    } else if (_passwordController.text.trim() !=
        _repeatPasswordController.text.trim()) {
      var snackBar = const SnackBar(
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
          content: Text('Passwords are not the same',
              style: TextStyle(fontFamily: 'RobotoR')));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    } else if ((_passwordController.text.trim() ==
            _repeatPasswordController.text.trim()) &
        _passwordController.text.trim().isNotEmpty &
        _repeatPasswordController.text.trim().isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addUser(String firstname, String lastname, String email) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'time': Timestamp.fromDate(DateTime.now())
    });
  }

  Future signUp() async {
    Provider.of<ModelProvider>(context, listen: false).resetLocalTransacion;
    if (PasswordConfirm()) {
      LoadingScreen().show(context: context, text: 'Please wait a moment....');
      // provider.resetLocalTransacion();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      await addUser(_firstnameController.text.trim(),
          _lastnameController.text.trim(), _emailController.text.trim());

      // await provider.setPriceOnline();
      // await provider.setCharts();
      // await provider.initialTransaction();
      // LoadingScreen().hide();
    }
  }

  // @override
  // void initState() {
  //   Provider.of<ModelProvider>(context).resetLocalTransacion();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,

        //   backgroundColor: KbackgroundColor,
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
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
                    SizedBox(height: size.height / 35),
                    const Text(
                      "Register",
                      style: TextStyle(
                          fontFamily: 'BebasNeueR',
                          color: Colors.white,
                          fontSize: 45),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        InputListtileRegisterPage(
                          controller: _firstnameController,
                          icon: Icons.abc,
                          hinttext: 'Jack',
                          textInputType: TextInputType.name,
                          title: 'Firstname',
                        ),
                        InputListtileRegisterPage(
                          controller: _lastnameController,
                          icon: Icons.abc,
                          hinttext: 'Ramsay',
                          textInputType: TextInputType.name,
                          title: 'Lastname',
                        ),
                        InputListtileRegisterPage(
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          hinttext: 'CryptoWallet@email.com',
                          textInputType: TextInputType.emailAddress,
                          title: 'Email',
                        ),
                        RegisterPagePasswordListtile(
                          controller: _passwordController,
                          title: 'Password',
                          hinttext: 'Choose your password',
                          icon: Icons.password_outlined,
                        ),
                        RegisterPagePasswordListtile(
                            controller: _repeatPasswordController,
                            title: 'Repeat Password',
                            hinttext: 'Repeat Password',
                            icon: Icons.password_outlined),
                        const SizedBox(
                          height: 20,
                        ),
                        ApplyButton(
                          width: size.width,
                          size: size,
                          onTap: signUp,
                          color: Colors.white.withOpacity(0.4),
                          text: 'Register',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Member? ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'CharisSILB'),
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text("Login Now!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: KsuboptionColor,
                                      fontSize: 15,
                                      fontFamily: 'CharisSILB')),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
