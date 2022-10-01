import 'package:crypto_font_icons/crypto_font_icon_data.dart';
import 'package:crypto_wallet/widgets/home_page_chart_middle.dart';
import 'package:flutter/material.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';

class CryptoTile extends StatelessWidget {
  final String currency;
  final IconData icon;
  final Color iconColor;
  final String price;
  final Color beginChartColor;
  final Color endChartColor;

  final Color beginBleowChartColor;
  final Color endBleowChartColor;
  final List spotlist;
  const CryptoTile(
      {required this.icon,
      required this.price,
      required this.beginChartColor,
      required this.endChartColor,
      required this.beginBleowChartColor,
      required this.endBleowChartColor,
      required this.iconColor,
      required this.currency,
      required this.spotlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 0, left: 10),
      // height: 200,
      height: 72,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 35,
          ),
          Text(
            "$price\$",
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'CharisSILB',
                color: Color(0xFFECEBE9)),
          ),
          Container(
              height: 67,
              padding: EdgeInsets.only(top: 10),
              width: 150,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: HomePageChartMiddle(
                spotlist: spotlist,
                currency: currency,
                beginChartColor: beginChartColor,
                endChartColor: endChartColor,
                beginBleowChartColor: beginBleowChartColor,
                endBleowChartColor: endBleowChartColor,
              )),
        ],
      ),
    );
  }
}
