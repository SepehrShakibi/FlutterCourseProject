import 'package:flutter/material.dart';

import 'package:crypto_wallet/constant.dart';

class PasswordTextField extends StatelessWidget {
  final IconData? prefixIcon;
  final String hintText;
  final TextEditingController controller;

  const PasswordTextField(
      {required this.prefixIcon,
      required this.hintText,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: KdisableBorderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: KborderColor, width: 2)),
            prefixIcon: Icon(
              prefixIcon,
              color: KiconColor,
            ),
            hintText: hintText,
            hintStyle:
                TextStyle(color: Colors.grey[400], fontFamily: 'OpenSansR')),
        style: TextStyle(color: Colors.white, fontFamily: 'OpenSansR'));
  }
}
