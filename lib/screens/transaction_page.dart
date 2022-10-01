import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/model/provider_model.dart';
import 'package:crypto_wallet/widgets/expense_container.dart';
import 'package:crypto_wallet/widgets/icons/btc_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/eth_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/usd_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/exchange_container.dart';
import 'package:crypto_wallet/widgets/icons/usdt_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/income_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/home_page_recent_transaction/box/income_box.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ModelProvider>(context, listen: false)
          .initialTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 28, 28, 28),
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            "Transaction List",
            style: TextStyle(
                fontFamily: 'CharisSILB', color: Colors.white, fontSize: 27),
            textAlign: TextAlign.center,
          ),
        ),
        centerTitle: true,
        leading: Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
                onPressed: (() => Navigator.pop(context)))),
      ),

      body: Container(
        padding: EdgeInsets.only(top: 10),
        width: double.infinity,
        child: Provider.of<ModelProvider>(context, listen: false)
                    .getTransactionList
                    .length ==
                0
            ? Text(
                "No Transaction",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'RobotoR',
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: Provider.of<ModelProvider>(context, listen: false)
                    .getTransactionList
                    .length,
                itemBuilder: (context, index) {
                  switch (Provider.of<ModelProvider>(context, listen: false)
                      .getTransactionList[index]
                      .type) {
                    case 'income':
                      return IncomeContainer(
                        color: index % 2 == 0
                            ? KButtonBackgroundColor3
                            : Colors.transparent,
                        icon: Provider.of<ModelProvider>(context, listen: false)
                            .getRecentTransactionIcon(
                                Provider.of<ModelProvider>(context,
                                        listen: false)
                                    .getTransactionList[index]
                                    .beginCurrency),
                        time: DateFormat.Hms()
                            .format(
                              Provider.of<ModelProvider>(context, listen: false)
                                  .getTransactionList[index]
                                  .dateTime,
                            )
                            .toString(),
                        date: DateFormat('dd-MM-yyyy').format(
                            Provider.of<ModelProvider>(context, listen: false)
                                .getTransactionList[index]
                                .dateTime),
                        count:
                            Provider.of<ModelProvider>(context, listen: false)
                                .getTransactionList[index]
                                .count
                                .toString(),
                      );

                    case 'exchange':
                      return ExchangeContainer(
                        color: index % 2 == 0
                            ? KButtonBackgroundColor3
                            : Colors.transparent,
                        beginIcon:
                            Provider.of<ModelProvider>(context, listen: false)
                                .getRecentTransactionIcon(
                                    Provider.of<ModelProvider>(context,
                                            listen: false)
                                        .getTransactionList[index]
                                        .beginCurrency),
                        endIcon:
                            Provider.of<ModelProvider>(context, listen: false)
                                .getRecentTransactionIcon(
                                    Provider.of<ModelProvider>(context,
                                            listen: false)
                                        .getTransactionList[index]
                                        .endCurrency),
                        time: DateFormat.Hms()
                            .format(
                              Provider.of<ModelProvider>(context, listen: false)
                                  .getTransactionList[index]
                                  .dateTime,
                            )
                            .toString(),
                        date: DateFormat('dd-MM-yyyy').format(
                            Provider.of<ModelProvider>(context, listen: false)
                                .getTransactionList[index]
                                .dateTime),
                        count:
                            Provider.of<ModelProvider>(context, listen: false)
                                .getTransactionList[index]
                                .count
                                .toString(),
                      );

                    case 'expense':
                      return ExpenseContainer(
                        color: index % 2 == 0
                            ? KButtonBackgroundColor3
                            : Colors.transparent,
                        icon: Provider.of<ModelProvider>(context, listen: false)
                            .getRecentTransactionIcon(
                                Provider.of<ModelProvider>(context,
                                        listen: false)
                                    .getTransactionList[index]
                                    .beginCurrency),
                        time: DateFormat.Hms()
                            .format(
                              Provider.of<ModelProvider>(context, listen: false)
                                  .getTransactionList[index]
                                  .dateTime,
                            )
                            .toString(),
                        date: DateFormat('dd-MM-yyyy').format(
                            Provider.of<ModelProvider>(context, listen: false)
                                .getTransactionList[index]
                                .dateTime),
                        count:
                            Provider.of<ModelProvider>(context, listen: false)
                                .getTransactionList[index]
                                .count
                                .toString(),
                      );

                    default:
                      return Text('NoThing');
                  }
                },
              ),
      ),
    );
  }
}
