import 'package:crypto_wallet/constants/route.dart';
import 'package:crypto_wallet/model/provider_model.dart';
import 'package:crypto_wallet/screens/forget_page.dart';
import 'package:crypto_wallet/screens/home_page.dart';
import 'package:crypto_wallet/screens/transaction_page.dart';
import 'package:crypto_wallet/screens/user_page.dart';
import 'package:flutter/material.dart';
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
      routes: allRoute(),
      onGenerateRoute: allGenerateRoute(),
    ),
  ));
}
