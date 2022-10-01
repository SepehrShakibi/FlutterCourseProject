import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const KbackgroundColor = Color(0xFF10100F);
const KiconColor = Color(0xFFdde8f0);
const KRegistericonColor = Color(0xFFFFFFFF);
const KborderColor = Color(0xFF81c8ee);
const KdisableBorderColor = Color(0xFFdde8f0);

const KButtonBackgroundColor1 = Color(0xFF018abd);

const KsuboptionColor = Color.fromARGB(255, 5, 188, 216);
const KButtonBackgroundColor3 = Color(0xFF6B99C3);

const KPrimaryColor = Color.fromARGB(255, 27, 23, 23);

//const KSubtitleColor = Color(0xFF88C2CE);
const KSubtitleColor = Color(0xFFffffff);

final List<DropdownMenuItem<String>> dropdownMenuItemConst = [
  DropdownMenuItem(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
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
