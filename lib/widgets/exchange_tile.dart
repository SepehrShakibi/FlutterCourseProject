import 'package:crypto_wallet/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExhcangeTile extends StatelessWidget {
  final Widget beginIcon;
  final Widget endIcon;
  final String count;
  final String time;
  final String date;

  const ExhcangeTile(
      {required this.beginIcon,
      required this.endIcon,
      required this.count,
      required this.time,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
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
                fontSize: 27,
                fontFamily: 'CharisSILB',
                fontWeight: FontWeight.bold,
                color: Color(0xFFECEBE9)),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: TextStyle(
                    color: Colors.grey.shade200.withOpacity(0.8),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                date,
                style: TextStyle(
                    color: Colors.grey.shade200.withOpacity(0.8),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        )
      ],
    );
  }
}
