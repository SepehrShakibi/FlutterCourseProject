import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_wallet/model/transaction.dart';
import 'package:crypto_wallet/widgets/income_container.dart';
import 'package:crypto_wallet/widgets/income_expense_widget/income_expense_dropdown_field.dart';
import 'package:crypto_wallet/widgets/apply_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:crypto_wallet/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../model/provider_model.dart';
import '../widgets/income_expense_widget/income_expense_dropdown_menu.dart';
import '../widgets/income_expense_widget/income_expense_toggle_button.dart';

Future<void> IncomExpenseDialog(BuildContext context, Size size) {
  double newValue = 0.0;
  DateTime dateTime;

  final List<Widget> _options = [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Text(
        'Income',
        style: TextStyle(
            fontSize: 18.5, fontFamily: 'RobotoR', fontWeight: FontWeight.w400),
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Text(
        'Expense',
        style: TextStyle(
            fontSize: 18.5, fontFamily: 'RobotoR', fontWeight: FontWeight.w400),
      ),
    ),
  ];
  List<bool> _isSelected = <bool>[true, false];

  bool _isIncome = true;

  ////dropdown
  ///
  String _selectedMenuValue = 'USD';
  final List<DropdownMenuItem<String>> _dropdownMenuItem = [
    DropdownMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: [
          // SizedBox(
          //   width: 7,
          // ),
          //   USDRecentTransactionIcon(),
          // Text(
          //   "\$",
          //   style: TextStyle(
          //       fontSize: 25,
          //       color: KiconColor,
          //       fontFamily: 'CharisSILB',
          //       backgroundColor: Color.fromARGB(255, 0, 0, 0)

          //       ),
          // ),
          Icon(
            FontAwesomeIcons.usd,
            size: 33.5,
            color: Colors.white,
          ),

          SizedBox(
            width: 5,
          ),
          Text(
            "USD",
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontFamily: 'OpenSansR'),
          )
        ],
      ),
      value: "USD",
    ),
    DropdownMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            CryptoFontIcons.BTC,
            size: 33.5,
            color: Color(0xFFea973d),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "BTC",
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontFamily: 'OpenSansR'),
          )
        ],
      ),
      value: 'BTC',
    ),
    DropdownMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            CryptoFontIcons.ETH,
            size: 33.5,
            color: Colors.blueAccent.shade400,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "ETH",
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontFamily: 'OpenSansR'),
          )
        ],
      ),
      value: 'ETH',
    ),
    DropdownMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            CryptoFontIcons.USDT,
            size: 33.5,
            color: Colors.greenAccent.shade400,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "USDT",
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontFamily: 'OpenSansR'),
          )
        ],
      ),
      value: 'USDT',
    ),
  ];

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
        //Color.fromARGB(255, 28, 28, 28),
        //Color.fromARGB(255, 34, 34, 34),
        backgroundColor: Color.fromARGB(255, 28, 28, 28),
        //  title: Text('Income/Expense'),
        content: Container(
          height: size.height * 0.58,
          width: size.width * 0.95,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Income Expense",
                      style: TextStyle(
                          fontFamily: 'CharisSILB',
                          color: Colors.white,
                          fontSize: 25),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.7,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 67, 67, 67),
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
                          //   disabledColor: Color.fromARGB(255, 221, 0, 0),
                          children: _options,
                          isSelected: _isSelected),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 10, bottom: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
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
                                borderSide: BorderSide(
                                    // color: Colors.white.withOpacity(1),
                                    color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    //  color: Colors.white.withOpacity(0.5),
                                    color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                            filled: true,
                            fillColor: Color.fromARGB(255, 56, 56, 56)
                            //  fillColor: Color.fromARGB(255, 19, 91, 178)
                            ),
                        dropdownColor: Color.fromARGB(255, 58, 58, 58),
                        borderRadius: BorderRadius.circular(15),
                        value: _selectedMenuValue,
                        items: _dropdownMenuItem,
                        onChanged: (String? value) {
                          setInnerState(() {
                            _selectedMenuValue = value!;
                            print(value);
                            // _selectedMenuValue = value;
                            // Provider.of<ModelProvider>(context, listen: false)
                            //     .setBeginCurrency(value);
                            //  print(Provider.of<ModelProvider>(context).getBeginCurrency);
                          });
                        }),
                    // SizedBox(
                    //   height: size.height * 0.002,
                    // ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 8, bottom: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
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
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    // color: Colors.white.withOpacity(1),
                                    color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    //  color: Colors.white.withOpacity(0.5),
                                    color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                            filled: true,
                            fillColor: Color.fromARGB(255, 56, 56, 56)
                            //  fillColor: Color.fromARGB(255, 19, 91, 178)
                            ,
                            // prefixIcon: Icon(
                            //   Icons.attach_money_outlined,
                            //   color: KRegistericonColor,
                            // ),
                            hintText: "Enter Count",
                            hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontFamily: 'OpenSansR',
                                fontSize: 15)),
                        style: TextStyle(
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
                              // print('in add bu');
                              // print(_isIncome);
                              // print(_selectedMenuValue);
                              // print(double.parse(_countController.text.trim()));

                              switch (_selectedMenuValue) {
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
                                      beginCurrency: _selectedMenuValue,
                                      endCurrency: 'nothing',
                                      count: double.parse(
                                          _countController.text.trim()),
                                      dateTime: dateTime));
                              print(Provider.of<ModelProvider>(context,
                                      listen: false)
                                  .getTransactionList
                                  .length);

                              String uid =
                                  await FirebaseAuth.instance.currentUser!.uid;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('transactions')
                                  .add({
                                'type': _isIncome ? 'income' : 'expense',
                                'beginCurrency': _selectedMenuValue,
                                'endCurrency': 'nothing',
                                'count':
                                    double.parse(_countController.text.trim()),
                                'dateTime': Timestamp.fromDate(dateTime)
                              });

                              // newValue =
                              //     double.parse(_countController.text.trim()) +
                              //         Provider.of<ModelProvider>(context,
                              //                 listen: false)
                              //             .GetETHBalance;
                              // print('new va');
                              // print(newValue);
                              // print('set bala');
                              // Provider.of<ModelProvider>(context, listen: false)
                              //     .setETHBalance(newValue);
                              // print('newba');
                              // print(Provider.of<ModelProvider>(context,
                              //         listen: false)
                              //     .GetETHBalance);

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
