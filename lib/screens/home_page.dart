import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_font_icons/crypto_font_icon_data.dart';
import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/model/provider_model.dart';
import 'package:crypto_wallet/widgets/icons/btc_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/eth_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/home_page_recent_transaction/box/exchange_box.dart';
import 'package:crypto_wallet/widgets/home_page_button.dart';
import 'package:crypto_wallet/widgets/home_page_chart_middle.dart';
import 'package:crypto_wallet/widgets/crypto_tile.dart';
import 'package:crypto_wallet/widgets/home_page_top_card.dart';
import 'package:crypto_wallet/widgets/home_pages_crypto_tiles.dart';
import 'package:crypto_wallet/widgets/home_page_recent_transaction/box/income_box.dart';
import 'package:crypto_wallet/widgets/home_page_recent_transaction/box/expense_box.dart';
import 'package:crypto_wallet/widgets/top_card_sub_currency.dart';
import 'package:crypto_wallet/widgets/icons/usd_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/usdt_recent_transaction_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/home_page_top_buttons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ModelProvider>(context, listen: false).initialBlance();
      await Provider.of<ModelProvider>(context, listen: false)
          .initialTransaction();
      print('object');

      await Provider.of<ModelProvider>(context, listen: false).setPriceOnline();
      await Provider.of<ModelProvider>(context, listen: false).setCharts();
    });
  }

  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //    elevation: 5,
        title: Text(
          "Home Page",
          style: TextStyle(
              fontFamily: 'CharisSILB', color: Colors.white, fontSize: 27),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Provider.of<ModelProvider>(context, listen: false)
                    .resetLocalTransacion;
              },
              icon: Icon(
                Icons.logout,
                //  color: KiconColor,
                size: 35,
              ))
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
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
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          HomePageTopCard(size: size),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          HomePageTopButtons(),
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
                                  Text(
                                    "Crypto",
                                    style: TextStyle(
                                        color: KSubtitleColor,
                                        fontSize: 19,
                                        fontFamily: 'CharisSILB',
                                        fontWeight: FontWeight.w300),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await Provider.of<ModelProvider>(context,
                                              listen: false)
                                          .setPriceOnline();
                                      await Provider.of<ModelProvider>(context,
                                              listen: false)
                                          .setCharts();
                                    },
                                    child: Text(
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
                              Divider(
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
                                  Text(
                                    "Recent Transactions",
                                    style: TextStyle(
                                        color: KSubtitleColor,
                                        fontSize: 19,
                                        fontFamily: 'CharisSILB',
                                        fontWeight: FontWeight.w300),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, 'transaction_list_page'),
                                    child: Text(
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
                              Divider(
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
                        return Container(
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
                                  return exchange_box(
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
                                  return Text('NoThing');
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
