import 'package:flutter/material.dart';

import 'package:crypto_wallet/constant.dart';

class RegisterPasswordextField extends StatelessWidget {
  final IconData prefixIcon;
  final String hintText;
  final TextEditingController controller;
  RegisterPasswordextField({
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
              color: KRegistericonColor,
            ),
            hintText: hintText,
            hintStyle:
                TextStyle(color: Colors.grey[400], fontFamily: 'OpenSansR')),
        style: TextStyle(color: Colors.white, fontFamily: 'OpenSansR'));
  }
}
