import 'package:flutter/material.dart';

import 'package:crypto_wallet/constant.dart';

class inputTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final IconData prefixIcon;
  final String hintText;
  inputTextField(
      {required this.hintText,
      required this.prefixIcon,
      required this.textInputType,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: textInputType,
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
