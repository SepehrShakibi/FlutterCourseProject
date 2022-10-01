import 'package:flutter/material.dart';

import 'exchange_tile.dart';

class ExchangeContainer extends StatelessWidget {
  final Color color;
  final Widget beginIcon;
  final Widget endIcon;
  final String count;
  final String time;
  final String date;

  const ExchangeContainer(
      {required this.color,
      required this.beginIcon,
      required this.endIcon,
      required this.count,
      required this.time,
      required this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 7),
        height: 72,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
        ),
        child: ExhcangeTile(
          beginIcon: beginIcon,
          endIcon: endIcon,
          count: count,
          time: time,
          date: date,
        ));
  }
}
