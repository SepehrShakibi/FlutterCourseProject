import 'package:crypto_wallet/constants/route.dart';
import 'package:crypto_wallet/model/provider_model.dart';
import 'package:crypto_wallet/screens/forget_page.dart';
import 'package:crypto_wallet/screens/home_page.dart';
import 'package:crypto_wallet/screens/transaction_page.dart';
import 'package:crypto_wallet/screens/user_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<ModelProvider>(
    create: (context) => ModelProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Currency Wallet',
      initialRoute: userPage,
      routes: {
        userPage: ((context) => const UserPage()),
        forgetPasswordPage: ((context) => const ForgetPasswordPage()),
        homePage: ((context) => const HomePage()),
        transactionListPage: (context) => const TransactionPage()
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case userPage:
            return PageTransition(
                child: const UserPage(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 350));

          case forgetPasswordPage:
            return PageTransition(
                child: const ForgetPasswordPage(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 350));
          case homePage:
            return PageTransition(
                child: const HomePage(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 350));
          case transactionListPage:
            return PageTransition(
                child: const TransactionPage(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 350));
          default:
            return PageTransition(
                child: const UserPage(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 350));
        }
      },

      //    home: const JUSTWHENCODING(),
    ),
  ));
}
