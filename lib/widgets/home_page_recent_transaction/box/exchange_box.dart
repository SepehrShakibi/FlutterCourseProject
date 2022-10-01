import 'package:crypto_wallet/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class exchange_box extends StatelessWidget {
  final Widget beginIcon;
  final Widget endIcon;
  final String count;

  const exchange_box(
      {required this.beginIcon, required this.endIcon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.grey.shade800.withOpacity(0.7),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  beginIcon,
                  Icon(
                    FontAwesomeIcons.arrowRight,
                    size: 30,
                    color: KiconColor,
                  ),
                  endIcon
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                count,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'CharisSILB',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFECEBE9)),
              ),
            ),
          ],
        ));
  }
}
