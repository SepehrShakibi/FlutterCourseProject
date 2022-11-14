import 'package:crypto_wallet/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto_wallet/model/provider_model.dart';

class IncomeExpenseToggleButton extends StatefulWidget {
  final List<Widget> _options = [
    const Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Text(
        'Income',
        style: TextStyle(
            fontSize: 18.5, fontFamily: 'RobotoR', fontWeight: FontWeight.w400),
      ),
    ),
    const Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Text(
        'Expense',
        style: TextStyle(
            fontSize: 18.5, fontFamily: 'RobotoR', fontWeight: FontWeight.w400),
      ),
    ),
  ];
  final List<bool> _isSelected = <bool>[true, false];

  IncomeExpenseToggleButton({Key? key}) : super(key: key);

  @override
  State<IncomeExpenseToggleButton> createState() =>
      _IncomeExpenseToggleButtonState();
}

class _IncomeExpenseToggleButtonState extends State<IncomeExpenseToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 67, 67, 67),
      ),
      child: ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < widget._isSelected.length; i++) {
                widget._isSelected[i] = index == i;
              }
              Provider.of<ModelProvider>(context, listen: false)
                  .setIsIncomeTransaction(widget._isSelected[0]);
            });
          },
          borderRadius: BorderRadius.circular(20),
          selectedBorderColor: Colors.white,
          selectedColor: KPrimaryColor,
          fillColor: Colors.grey.shade100,
          color: Colors.white,
          borderColor: Colors.grey.shade100,
          borderWidth: 1,
          isSelected: widget._isSelected,
          children: widget._options),
    );
  }
}
