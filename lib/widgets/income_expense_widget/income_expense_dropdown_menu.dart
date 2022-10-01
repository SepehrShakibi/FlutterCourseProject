import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/widgets/icons/btc_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/eth_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/usd_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/usdt_recent_transaction_icon.dart';
import 'package:flutter/material.dart';

class IncomeExpenseDropdownMenu extends StatefulWidget {
  IncomeExpenseDropdownMenu({Key? key}) : super(key: key);

  @override
  State<IncomeExpenseDropdownMenu> createState() =>
      _IncomeExpenseDropdownMenuState();
}

class _IncomeExpenseDropdownMenuState extends State<IncomeExpenseDropdownMenu> {
  String _selectedMenuValue = 'BTC';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      value: _selectedMenuValue,
      items: dropdownMenuItemConst,
      onChanged: (String? newValue) {
        setState(() {});
      },
      style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 20),
      dropdownColor: Color.fromARGB(255, 56, 56, 56),
      borderRadius: BorderRadius.circular(15),
    );
  }
}
