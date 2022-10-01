import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_wallet/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class USDRecentTransactionIcon extends StatelessWidget {
  const USDRecentTransactionIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            "\$",
            style: TextStyle(
              fontSize: 36,
              color: KiconColor,
              fontFamily: 'CharisSILB',
            ),
          ),
        ),
      ],
    );
  }
}
