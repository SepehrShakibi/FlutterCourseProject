import 'package:crypto_wallet/widgets/exchange/exchange_dropdown_field.dart';
import 'package:flutter/material.dart';

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
            children: const [
              ExchangeDropdownButton(),
              Divider(
                color: Colors.white,
                thickness: 0.7,
              ),
              Padding(
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
