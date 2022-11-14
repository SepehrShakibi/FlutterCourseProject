import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_wallet/model/provider_model.dart';
import 'package:crypto_wallet/model/transaction.dart';
import 'package:crypto_wallet/widgets/exchange/exchange_dropdown_field.dart';

import 'package:crypto_wallet/widgets/apply_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto_wallet/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

Future<void> ExhcangeDialog(BuildContext context, Size size) {
  DateTime dateTime;

//price
  double firstPrice = 1.0;
  double secondPrice =
      Provider.of<ModelProvider>(context, listen: false).GetETHPrice;

  ///
  final TextEditingController _firstCountController = TextEditingController();
  ////
  String finalValue = "";

  ///drop down exchange

  String _selectedMenuValueFirst = 'USD';
  String _selectedMenuValueSecond = 'ETH';
  final List<DropdownMenuItem<String>> _dropdownMenuItem = [
    DropdownMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: [
          const Icon(
            FontAwesomeIcons.dollarSign,
            size: 33.5,
            color: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          const Text(
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
          const Icon(
            CryptoFontIcons.BTC,
            size: 33.5,
            color: Color(0xFFea973d),
          ),
          const SizedBox(
            width: 5,
          ),
          const Text(
            "BTC",
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontFamily: 'OpenSansR'),
          )
        ],
      ),
      value: 'BTC',
    ),
    DropdownMenuItem(
      // ignore: sort_child_properties_last
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            CryptoFontIcons.ETH,
            size: 33.5,
            color: Colors.blueAccent.shade400,
          ),
          const SizedBox(
            width: 5,
          ),
          const Text(
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
          const SizedBox(
            width: 5,
          ),
          const Text(
            "USDT",
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontFamily: 'OpenSansR'),
          )
        ],
      ),
      value: 'USDT',
    ),
  ];
  /////////////////////////
  List<bool> _isSelected = [true, false];
  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.zero,
        backgroundColor: const Color.fromARGB(255, 28, 28, 28),
        content: SizedBox(
          //    padding: EdgeInsets.symmetric(vertical: 15),
          height: size.height * 0.63,
          width: size.width * 0.95,
          child: SingleChildScrollView(
            //physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Exchange",
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 56, 56, 56),
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Colors.redAccent, width: 2)),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  dropdownColor:
                                      const Color.fromARGB(255, 58, 58, 58),
                                  borderRadius: BorderRadius.circular(15),
                                  value: _selectedMenuValueFirst,
                                  items: _dropdownMenuItem,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedMenuValueFirst = value!;
                                      firstPrice = Provider.of<ModelProvider>(
                                              context,
                                              listen: false)
                                          .getPrice(value);
                                      if (_firstCountController
                                          .text.isNotEmpty) {
                                        finalValue = (double.parse(
                                                    _firstCountController
                                                        .text) *
                                                secondPrice /
                                                firstPrice)
                                            .toString();
                                      }
                                    });
                                  }),
                              const Divider(
                                color: Colors.white,
                                thickness: 0.7,
                              ),
                              TextFormField(
                                  controller: _firstCountController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      finalValue = (double.parse(value) *
                                              secondPrice /
                                              firstPrice)
                                          .toString();
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Color.fromARGB(255, 56, 56, 56)
                                      //  fillColor: Color.fromARGB(255, 19, 91, 178)
                                      ),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSansR',
                                      fontSize: 20)),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Icon(
                      FontAwesomeIcons.arrowDownLong,
                      color: Colors.white,
                      size: 35,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 56, 56, 56),
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Colors.greenAccent, width: 2)),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  dropdownColor:
                                      const Color.fromARGB(255, 58, 58, 58),
                                  borderRadius: BorderRadius.circular(15),
                                  value: _selectedMenuValueSecond,
                                  items: _dropdownMenuItem,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedMenuValueSecond = value!;
                                      secondPrice = Provider.of<ModelProvider>(
                                              context,
                                              listen: false)
                                          .getPrice(value);
                                      if (_firstCountController.text
                                          .trim()
                                          .isNotEmpty) {
                                        finalValue = (double.parse(
                                                    _firstCountController
                                                        .text) *
                                                secondPrice /
                                                firstPrice)
                                            .toString();
                                      }
                                    });
                                  }),
                              const Divider(
                                color: Colors.white,
                                thickness: 0.7,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                child: Text(
                                  finalValue,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSansR',
                                      fontSize: 20),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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

                              // DECREASE FIRST Currency
                              switch (_selectedMenuValueFirst) {
                                case 'USD':
                                  Provider.of<ModelProvider>(context,
                                          listen: false)
                                      .setUSDBalance(Provider.of<ModelProvider>(
                                                  context,
                                                  listen: false)
                                              .GetUSDBalance -
                                          double.parse(_firstCountController
                                              .text
                                              .trim()));
                                  break;
                                case 'BTC':
                                  Provider.of<ModelProvider>(context,
                                          listen: false)
                                      .setBTCBalance(Provider.of<ModelProvider>(
                                                  context,
                                                  listen: false)
                                              .GetBTCBalance -
                                          double.parse(_firstCountController
                                              .text
                                              .trim()));
                                  break;
                                case 'ETH':
                                  Provider.of<ModelProvider>(context,
                                          listen: false)
                                      .setETHBalance(Provider.of<ModelProvider>(
                                                  context,
                                                  listen: false)
                                              .GetETHBalance -
                                          double.parse(_firstCountController
                                              .text
                                              .trim()));
                                  break;
                                case 'USDT':
                                  Provider.of<ModelProvider>(context,
                                          listen: false)
                                      .setUSDTBalance(
                                          Provider.of<ModelProvider>(context,
                                                      listen: false)
                                                  .GetUSDTBalance -
                                              double.parse(_firstCountController
                                                  .text
                                                  .trim()));
                                  break;
                              }

                              //increase second currency
                              switch (_selectedMenuValueSecond) {
                                case 'USD':
                                  Provider.of<ModelProvider>(context,
                                          listen: false)
                                      .setUSDBalance(Provider.of<ModelProvider>(
                                                  context,
                                                  listen: false)
                                              .GetUSDBalance +
                                          double.parse(finalValue));
                                  break;
                                case 'BTC':
                                  Provider.of<ModelProvider>(context,
                                          listen: false)
                                      .setBTCBalance(Provider.of<ModelProvider>(
                                                  context,
                                                  listen: false)
                                              .GetBTCBalance +
                                          double.parse(finalValue));
                                  break;
                                case 'ETH':
                                  Provider.of<ModelProvider>(context,
                                          listen: false)
                                      .setETHBalance(Provider.of<ModelProvider>(
                                                  context,
                                                  listen: false)
                                              .GetETHBalance +
                                          double.parse(finalValue));
                                  break;
                                case 'USDT':
                                  Provider.of<ModelProvider>(context,
                                          listen: false)
                                      .setUSDTBalance(
                                          Provider.of<ModelProvider>(context,
                                                      listen: false)
                                                  .GetUSDTBalance +
                                              double.parse(finalValue));
                                  break;
                              }
                              await Provider.of<ModelProvider>(context,
                                      listen: false)
                                  .UpdateFirestoreBalance();

                              Provider.of<ModelProvider>(context, listen: false)
                                  .addLocalTransacion(TransactionModel(
                                      type: 'exchange',
                                      beginCurrency: _selectedMenuValueFirst,
                                      endCurrency: _selectedMenuValueSecond,
                                      count: double.parse(
                                          _firstCountController.text.trim()),
                                      dateTime: dateTime));

                              String uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('transactions')
                                  .add({
                                'type': 'exchange',
                                'beginCurrency': _selectedMenuValueFirst,
                                'endCurrency': _selectedMenuValueSecond,
                                'count': double.parse(
                                    _firstCountController.text.trim()),
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

class CurrencyTextWidget extends StatelessWidget {
  const CurrencyTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 56, 56, 56),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.greenAccent, width: 2)),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ExchangeDropdownButton(),
              const Divider(
                color: Colors.white,
                thickness: 0.7,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: Text(
                  "Final Price",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSansR',
                      fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
