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
      initialRoute: 'user_page',
      routes: {
        'user_page': ((context) => const UserPage()),
        'forget_password_page': ((context) => const ForgetPasswordPage()),
        'home_page': ((context) => const HomePage()),
        'transaction_list_page': (context) => const TransactionPage()
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'user_page':
            return PageTransition(
                child: UserPage(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 350));

          case 'forget_password_page':
            return PageTransition(
                child: ForgetPasswordPage(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 350));
          case 'home_page':
            return PageTransition(
                child: HomePage(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 350));
          case 'transaction_list_page':
            return PageTransition(
                child: TransactionPage(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 350));
        }
      },

      //    home: const JUSTWHENCODING(),
    ),
  ));
}
