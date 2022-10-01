import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/widgets/icons/btc_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/eth_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/usd_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/usdt_recent_transaction_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//////////
class ExchangeDropdownButton extends StatefulWidget {
  const ExchangeDropdownButton({Key? key}) : super(key: key);

  @override
  State<ExchangeDropdownButton> createState() => _ExchangeDropdownButtonState();
}

class _ExchangeDropdownButtonState extends State<ExchangeDropdownButton> {
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

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(border: InputBorder.none),
        dropdownColor: Color.fromARGB(255, 58, 58, 58),
        borderRadius: BorderRadius.circular(15),
        value: _selectedMenuValue,
        items: _dropdownMenuItem,
        onChanged: (value) {});
  }
}
