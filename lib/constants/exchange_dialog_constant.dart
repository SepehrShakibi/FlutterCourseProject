import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String finalValue = "";

///drop down exchange
String selectedMenuValueFirst = 'USD';
String selectedMenuValueSecond = 'ETH';
final List<DropdownMenuItem<String>> dropdownMenuItem = [
  const DropdownMenuItem(
    value: "USD",
    child: DropDownRowWidget(
      icon: FontAwesomeIcons.dollarSign,
      color: Colors.white,
      name: 'BTC',
    ),
  ),
  const DropdownMenuItem(
    value: 'BTC',
    child: DropDownRowWidget(
      icon: CryptoFontIcons.ETH,
      color: Color(0xFFea973d),
      name: 'BTC',
    ),
  ),
  DropdownMenuItem(
    value: 'ETH',
    child: DropDownRowWidget(
      icon: CryptoFontIcons.ETH,
      color: Colors.blueAccent.shade400,
      name: 'ETH',
    ),
  ),
  DropdownMenuItem(
    value: 'USDT',
    child: DropDownRowWidget(
      icon: CryptoFontIcons.USDT,
      color: Colors.greenAccent.shade400,
      name: 'USDT',
    ),
  ),
];

class DropDownRowWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String name;
  const DropDownRowWidget({
    Key? key,
    required this.color,
    required this.icon,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 33.5,
          color: color,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          name,
          style: const TextStyle(
              fontSize: 22, color: Colors.white, fontFamily: 'OpenSansR'),
        )
      ],
    );
  }
}
