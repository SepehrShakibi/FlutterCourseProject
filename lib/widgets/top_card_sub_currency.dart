import 'package:flutter/material.dart';

class TopCardSubCurrency extends StatelessWidget {
  final IconData icon;
  final String price;

  const TopCardSubCurrency({required this.icon, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 35,
        ),
        // Text(
        //   "BTC",
        //   style: TextStyle(
        //       fontFamily: 'CharisSILB',
        //       fontWeight: FontWeight.bold,
        //       fontSize: 25,
        //       color: Color(0xFFF4F9FC)),
        // ),
        Text(
          price,
          style: TextStyle(
              fontFamily: 'CharisSILB',
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Color(0xFFF4F9FC)),
        ),
      ],
    );
  }
}
