import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/constants/route.dart';
import 'package:crypto_wallet/popup/exhange_dialog.dart';
import 'package:crypto_wallet/widgets/icons/btc_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/vertical_line.dart';
import 'package:flutter/material.dart';

import 'home_page_button.dart';
import 'icons/eth_recent_transaction_icon.dart';
import '../popup/income_expense_dialog.dart';

class HomePageTopButtons extends StatelessWidget {
  const HomePageTopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      color: Colors.transparent,
      elevation: 15,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(1),
            borderRadius: BorderRadius.circular(45)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 100,
              child: HomePageButton(
                onPressed: () async {
                  return await ExhcangeDialog(context, size);
                },
                icon: Icons.sync_alt_sharp,
                title: "Exchange",
              ),
            ),
            Expanded(
              flex: 1,
              child: VerticalLine(
                horizantalSpace: 0,
                lineHeight: 60,
                lineWidth: 1,
              ),
            ),
            Expanded(
              flex: 100,
              child: HomePageButton(
                onPressed: () async {
                  return await IncomExpenseDialog(context, size);
                },
                icon: Icons.price_change_outlined,
                title: "In/Ex",
              ),
            ),
            Expanded(
              flex: 1,
              child: VerticalLine(
                horizantalSpace: 0,
                lineHeight: 60,
                lineWidth: 1,
              ),
            ),
            Expanded(
              flex: 100,
              child: HomePageButton(
                onPressed: () =>
                    Navigator.pushNamed(context, transactionListPage),
                icon: Icons.currency_exchange_rounded,
                title: "Transaction",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
