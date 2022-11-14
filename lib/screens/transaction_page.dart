import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/helpers/loading/loading_screen.dart';
import 'package:crypto_wallet/model/provider_model.dart';
import 'package:crypto_wallet/widgets/expense_container.dart';
import 'package:crypto_wallet/widgets/exchange_container.dart';
import 'package:crypto_wallet/widgets/income_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ModelProvider>(context, listen: false)
          .initialTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 28, 28, 28),
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 18.0),
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
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
                onPressed: (() => Navigator.pop(context)))),
      ),

      body: Container(
        padding: const EdgeInsets.only(top: 10),
        width: double.infinity,
        child: Provider.of<ModelProvider>(context, listen: false)
                .getTransactionList
                .isEmpty
            ? const Text(
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
                      return const Text('NoThing');
                  }
                },
              ),
      ),
    );
  }
}
