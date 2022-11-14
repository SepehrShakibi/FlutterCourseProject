import 'package:crypto_font_icons/crypto_font_icons.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//////////
class ExchangeDropdownButton extends StatefulWidget {
  const ExchangeDropdownButton({Key? key}) : super(key: key);

  @override
  State<ExchangeDropdownButton> createState() => _ExchangeDropdownButtonState();
}

class _ExchangeDropdownButtonState extends State<ExchangeDropdownButton> {
  final String _selectedMenuValue = 'USD';
  final List<DropdownMenuItem<String>> _dropdownMenuItem = [
    DropdownMenuItem(
      value: "USD",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: const [
          Icon(
            FontAwesomeIcons.dollarSign,
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
    ),
    DropdownMenuItem(
      value: 'BTC',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
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
    ),
    DropdownMenuItem(
      value: 'ETH',
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
    ),
    DropdownMenuItem(
      value: 'USDT',
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
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: const InputDecoration(border: InputBorder.none),
        dropdownColor: const Color.fromARGB(255, 58, 58, 58),
        borderRadius: BorderRadius.circular(15),
        value: _selectedMenuValue,
        items: _dropdownMenuItem,
        onChanged: (value) {});
  }
}
