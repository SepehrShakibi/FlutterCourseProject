import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/constants/route.dart';
import 'package:crypto_wallet/helpers/loading/loading_screen.dart';
import 'package:crypto_wallet/model/provider_model.dart';

import 'package:crypto_wallet/widgets/home_page_recent_transaction/box/exchange_box.dart';

import 'package:crypto_wallet/widgets/home_page_top_card.dart';
import 'package:crypto_wallet/widgets/home_pages_crypto_tiles.dart';
import 'package:crypto_wallet/widgets/home_page_recent_transaction/box/income_box.dart';
import 'package:crypto_wallet/widgets/home_page_recent_transaction/box/expense_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/home_page_top_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<ModelProvider>(context, listen: false);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      LoadingScreen().show(context: context, text: 'Please wait a moment....');
      await provider.initialBlance();
      await provider.initialTransaction();
      await provider.setPriceOnline();
      await provider.setCharts();
      LoadingScreen().hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<ModelProvider>(context, listen: false);
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var size = MediaQuery.of(context).size;

    final provider = Provider.of<ModelProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Home Page",
          style: TextStyle(
              fontFamily: 'CharisSILB', color: Colors.white, fontSize: 27),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                provider.resetData();

                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout,
                size: 35,
              ))
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/home_page_2.jpg'),
                fit: BoxFit.cover,
                opacity: 0.2)),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          HomePageTopCard(size: size),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          const HomePageTopButtons(),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Crypto",
                                    style: TextStyle(
                                        color: KSubtitleColor,
                                        fontSize: 19,
                                        fontFamily: 'CharisSILB',
                                        fontWeight: FontWeight.w300),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      LoadingScreen().show(
                                          context: context,
                                          text: 'Please wait a moment....');
                                      await Provider.of<ModelProvider>(context,
                                              listen: false)
                                          .setPriceOnline();
                                      await provider.setCharts();
                                      LoadingScreen().hide();
                                    },
                                    child: const Text(
                                      "Update",
                                      style: TextStyle(
                                          color: KSubtitleColor,
                                          fontSize: 16,
                                          fontFamily: 'CharisSILB',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                              const Divider(
                                color: KSubtitleColor,
                                thickness: 1,
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          HomePageCryptoTiles(size: size),
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Recent Transactions",
                                    style: TextStyle(
                                        color: KSubtitleColor,
                                        fontSize: 19,
                                        fontFamily: 'CharisSILB',
                                        fontWeight: FontWeight.w300),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, transactionListPage),
                                    child: const Text(
                                      "See all",
                                      style: TextStyle(
                                          color: KSubtitleColor,
                                          fontSize: 16,
                                          fontFamily: 'CharisSILB',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                              const Divider(
                                color: KSubtitleColor,
                                thickness: 1,
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .collection('transactions')
                          .orderBy('dateTime')
                          .get(),
                      builder: (context, snapshot) {
                        return SizedBox(
                          height: 110,
                          width: double.infinity,
                          child: ListView.builder(
                            //   reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: Provider.of<ModelProvider>(context,
                                    listen: false)
                                .getTransactionList
                                .length,
                            itemBuilder: (context, index) {
                              switch (Provider.of<ModelProvider>(context,
                                      listen: false)
                                  .getTransactionList[index]
                                  .type) {
                                case 'income':
                                  return IncomeBox(
                                    icon: Provider.of<ModelProvider>(context,
                                            listen: false)
                                        .getRecentTransactionIcon(
                                            Provider.of<ModelProvider>(context,
                                                    listen: false)
                                                .getTransactionList[index]
                                                .beginCurrency),
                                    count: Provider.of<ModelProvider>(context,
                                            listen: false)
                                        .getTransactionList[index]
                                        .count
                                        .toString(),
                                  );

                                case 'exchange':
                                  return ExchangeBox(
                                    beginIcon: Provider.of<ModelProvider>(
                                            context,
                                            listen: false)
                                        .getRecentTransactionIcon(
                                            Provider.of<ModelProvider>(context,
                                                    listen: false)
                                                .getTransactionList[index]
                                                .beginCurrency),
                                    endIcon: Provider.of<ModelProvider>(context,
                                            listen: false)
                                        .getRecentTransactionIcon(
                                            Provider.of<ModelProvider>(context,
                                                    listen: false)
                                                .getTransactionList[index]
                                                .endCurrency),
                                    count: Provider.of<ModelProvider>(context,
                                            listen: false)
                                        .getTransactionList[index]
                                        .count
                                        .toString(),
                                  );

                                case 'expense':
                                  return ExpenseBox(
                                    icon: Provider.of<ModelProvider>(context,
                                            listen: false)
                                        .getRecentTransactionIcon(
                                            Provider.of<ModelProvider>(context,
                                                    listen: false)
                                                .getTransactionList[index]
                                                .beginCurrency),
                                    count: Provider.of<ModelProvider>(context,
                                            listen: false)
                                        .getTransactionList[index]
                                        .count
                                        .toString(),
                                  );
                                default:
                                  return const Text('NoThing');
                              }
                            },
                          ),
                        );
                      },
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
