// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/transaction.dart';
import 'package:crypto_wallet/widgets/apply_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto_wallet/constant.dart';
import 'package:provider/provider.dart';
import 'package:crypto_wallet/constants/incom_expense_dialog_constant.dart';
import '../model/provider_model.dart';

Future<void> IncomExpenseDialog(BuildContext context, Size size) {
  double newValue = 0.0;
  DateTime dateTime;

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
  List<bool> _isSelected = <bool>[true, false];

  bool _isIncome = true;

  ///
  ///
  /////// count text field!!
  final TextEditingController _countController = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setInnerState) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color.fromARGB(255, 28, 28, 28),
        content: SizedBox(
          height: size.height * 0.58,
          width: size.width * 0.95,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Income Expense",
                      style: TextStyle(
                          fontFamily: 'CharisSILB',
                          color: Colors.white,
                          fontSize: 25),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.7,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 67, 67, 67),
                      ),
                      child: ToggleButtons(
                          direction: Axis.horizontal,
                          onPressed: (int index) {
                            setInnerState(() {
                              for (int i = 0; i < _isSelected.length; i++) {
                                _isSelected[i] = index == i;
                              }
                              // Provider.of<ModelProvider>(context, listen: false)
                              //     .setIsIncomeTransaction(_isSelected[0]);
                              _isIncome = _isSelected[0];
                            });
                          },
                          borderRadius: BorderRadius.circular(20),
                          selectedBorderColor: Colors.white,
                          selectedColor: KPrimaryColor,
                          fillColor: Colors.grey.shade100,
                          //    fillColor: Colors.white,
                          // color: Colors.grey.shade100,
                          color: Colors.white,
                          borderColor: Colors.grey.shade100,
                          borderWidth: 1,
                          isSelected: _isSelected,
                          //   disabledColor: Color.fromARGB(255, 221, 0, 0),
                          children: _options),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 10, bottom: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Currency:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'CharisSILB',
                              color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    // Divider(
                    //   color: Colors.white,
                    // ),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 56, 56, 56)),
                        dropdownColor: const Color.fromARGB(255, 58, 58, 58),
                        borderRadius: BorderRadius.circular(15),
                        value: selectedMenuValue,
                        items: dropdownMenuItem,
                        onChanged: (String? value) {
                          setInnerState(() {
                            selectedMenuValue = value!;
                          });
                        }),

                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 8, bottom: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Count:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'CharisSILB',
                              color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    TextFormField(
                        controller: _countController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 56, 56, 56),
                            hintText: "Enter Count",
                            hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontFamily: 'OpenSansR',
                                fontSize: 15)),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSansR',
                            fontSize: 20)),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ApplyButton(
                            width: size.width / 3.toDouble(),
                            size: size,
                            onTap: () async {
                              dateTime = DateTime.now();

                              switch (selectedMenuValue) {
                                case 'USD':
                                  newValue = _isIncome
                                      ? double.parse(
                                              _countController.text.trim()) +
                                          Provider.of<ModelProvider>(context,
                                                  listen: false)
                                              .GetUSDBalance
                                      : Provider.of<ModelProvider>(context,
                                                  listen: false)
                                              .GetUSDBalance -
                                          double.parse(
                                              _countController.text.trim());
                                  Provider.of<ModelProvider>(context,
                                          listen: false)
                                      .setUSDBalance(newValue);
                                  break;
                                case 'BTC':
                                  newValue = _isIncome
                                      ? double.parse(
                                              _countController.text.trim()) +
                                          Provider.of<ModelProvider>(context,
                                                  listen: false)
                                              .GetBTCBalance
                                      : Provider.of<ModelProvider>(context,
                                                  listen: false)
                                              .GetBTCBalance -
                                          double.parse(
                                              _countController.text.trim());
                                  Provider.of<ModelProvider>(context,
                                          listen: false)
                                      .setBTCBalance(newValue);
                                  break;
                                case 'ETH':
                                  newValue = _isIncome
                                      ? double.parse(
                                              _countController.text.trim()) +
                                          Provider.of<ModelProvider>(context,
                                                  listen: false)
                                              .GetETHBalance
                                      : Provider.of<ModelProvider>(context,
                                                  listen: false)
                                              .GetETHBalance -
                                          double.parse(
                                              _countController.text.trim());

                                  Provider.of<ModelProvider>(context,
                                          listen: false)
                                      .setETHBalance(newValue);
                                  break;
                                case 'USDT':
                                  newValue = _isIncome
                                      ? double.parse(
                                              _countController.text.trim()) +
                                          Provider.of<ModelProvider>(context,
                                                  listen: false)
                                              .GetUSDTBalance
                                      : Provider.of<ModelProvider>(context,
                                                  listen: false)
                                              .GetUSDTBalance -
                                          double.parse(
                                              _countController.text.trim());

                                  Provider.of<ModelProvider>(context,
                                          listen: false)
                                      .setUSDTBalance(newValue);
                                  break;
                              }

                              Provider.of<ModelProvider>(context, listen: false)
                                  .UpdateFirestoreBalance();
                              Provider.of<ModelProvider>(context, listen: false)
                                  .addLocalTransacion(TransactionModel(
                                      type: _isIncome ? 'income' : 'expense',
                                      beginCurrency: selectedMenuValue,
                                      endCurrency: 'nothing',
                                      count: double.parse(
                                          _countController.text.trim()),
                                      dateTime: dateTime));

                              String uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('transactions')
                                  .add({
                                'type': _isIncome ? 'income' : 'expense',
                                'beginCurrency': selectedMenuValue,
                                'endCurrency': 'nothing',
                                'count':
                                    double.parse(_countController.text.trim()),
                                'dateTime': Timestamp.fromDate(dateTime)
                              });

                              Navigator.pop(context);
                            },
                            color: KButtonBackgroundColor1,
                            text: 'Apply'),
                        ApplyButton(
                            width: size.width / 3.toDouble(),
                            size: size,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            color: Colors.blueGrey.shade900.withOpacity(0.5),
                            text: 'Cancel')
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    ),
  );
}
