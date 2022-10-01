import 'package:flutter/material.dart';

import '../constant.dart';

class ApplyButton extends StatelessWidget {
  final Size size;
  final VoidCallback onTap;
  final Color color;
  final String text;
  final double width;
  const ApplyButton(
      {required this.size,
      required this.onTap,
      required this.color,
      required this.text,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
          vertical: size.height / 60,
        ),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'OpenSansL',
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
