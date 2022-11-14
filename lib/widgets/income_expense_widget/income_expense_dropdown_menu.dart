import 'package:crypto_wallet/constant.dart';

import 'package:flutter/material.dart';

class IncomeExpenseDropdownMenu extends StatefulWidget {
  const IncomeExpenseDropdownMenu({Key? key}) : super(key: key);

  @override
  State<IncomeExpenseDropdownMenu> createState() =>
      _IncomeExpenseDropdownMenuState();
}

class _IncomeExpenseDropdownMenuState extends State<IncomeExpenseDropdownMenu> {
  final String _selectedMenuValue = 'BTC';

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
      dropdownColor: const Color.fromARGB(255, 56, 56, 56),
      borderRadius: BorderRadius.circular(15),
    );
  }
}
