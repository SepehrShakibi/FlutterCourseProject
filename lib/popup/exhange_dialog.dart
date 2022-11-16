import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/constants/exchange_dialog_constant.dart';
import 'package:crypto_wallet/helpers/loading/loading_screen.dart';
import 'package:crypto_wallet/model/provider_model.dart';
import 'package:crypto_wallet/model/transaction.dart';
import 'package:crypto_wallet/widgets/apply_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto_wallet/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

Future<void> exhcangeDialog(BuildContext context, Size size) {
  final provider = Provider.of<ModelProvider>(context, listen: false);

  DateTime dateTime;

//price
  double firstPrice = 1.0;
  double secondPrice = provider.GetETHPrice;

  final TextEditingController firstCountController = TextEditingController();

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
                                  value: provider.ExchangeDialogFirstValue,
                                  items: dropdownMenuItem,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedMenuValueFirst = value!;
                                      firstPrice = provider.getPrice(value);
                                      if (firstCountController
                                          .text.isNotEmpty) {
                                        finalValue = (double.parse(
                                                    firstCountController.text) *
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
                                  controller: firstCountController,
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
                                  value: selectedMenuValueSecond,
                                  items: dropdownMenuItem,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedMenuValueSecond = value!;
                                      secondPrice = provider.getPrice(value);
                                      if (firstCountController.text
                                          .trim()
                                          .isNotEmpty) {
                                        finalValue = (double.parse(
                                                    firstCountController.text) *
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
                              LoadingScreen().show(
                                  context: context,
                                  text: 'Please wait a moment....');
                              dateTime = DateTime.now();

                              // DECREASE FIRST Currency
                              switch (selectedMenuValueFirst) {
                                case 'USD':
                                  provider.setUSDBalance(provider
                                          .GetUSDBalance -
                                      double.parse(
                                          firstCountController.text.trim()));
                                  break;
                                case 'BTC':
                                  provider.setBTCBalance(provider
                                          .GetBTCBalance -
                                      double.parse(
                                          firstCountController.text.trim()));
                                  break;
                                case 'ETH':
                                  provider.setETHBalance(provider
                                          .GetETHBalance -
                                      double.parse(
                                          firstCountController.text.trim()));
                                  break;
                                case 'USDT':
                                  provider.setUSDTBalance(provider
                                          .GetUSDTBalance -
                                      double.parse(
                                          firstCountController.text.trim()));
                                  break;
                              }

                              //increase second currency
                              switch (selectedMenuValueSecond) {
                                case 'USD':
                                  provider.setUSDBalance(
                                      provider.GetUSDBalance +
                                          double.parse(finalValue));
                                  break;
                                case 'BTC':
                                  provider.setBTCBalance(
                                      provider.GetBTCBalance +
                                          double.parse(finalValue));
                                  break;
                                case 'ETH':
                                  provider.setETHBalance(
                                      provider.GetETHBalance +
                                          double.parse(finalValue));
                                  break;
                                case 'USDT':
                                  provider.setUSDTBalance(
                                      provider.GetUSDTBalance +
                                          double.parse(finalValue));
                                  break;
                              }
                              await provider.UpdateFirestoreBalance();

                              provider.addLocalTransacion(TransactionModel(
                                  type: 'exchange',
                                  beginCurrency: selectedMenuValueFirst,
                                  endCurrency: selectedMenuValueSecond,
                                  count: double.parse(
                                      firstCountController.text.trim()),
                                  dateTime: dateTime));

                              String uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('transactions')
                                  .add({
                                'type': 'exchange',
                                'beginCurrency': selectedMenuValueFirst,
                                'endCurrency': selectedMenuValueSecond,
                                'count': double.parse(
                                    firstCountController.text.trim()),
                                'dateTime': Timestamp.fromDate(dateTime)
                              });

                              Navigator.pop(context);
                              LoadingScreen().hide();
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
