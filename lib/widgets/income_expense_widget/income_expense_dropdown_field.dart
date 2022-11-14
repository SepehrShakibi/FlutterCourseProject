// ignore_for_file: unused_field

import 'package:crypto_wallet/constant.dart';

import 'package:flutter/material.dart';

class DropDownButtonField extends StatefulWidget {
  final StateSetter stset;
  String selectedValue;
  DropDownButtonField({
    Key? key,
    required this.stset,
    required this.selectedValue,
  }) : super(key: key);

  @override
  State<DropDownButtonField> createState() => _DropDownButtonFieldState();
}

class _DropDownButtonFieldState extends State<DropDownButtonField> {
  String _selectedMenuValue = 'USD';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15)),
            filled: true,
            fillColor: const Color.fromARGB(255, 56, 56, 56)),
        dropdownColor: const Color.fromARGB(255, 58, 58, 58),
        borderRadius: BorderRadius.circular(15),
        value: widget.selectedValue,
        items: dropdownMenuItemConst,
        onChanged: (String? value) {
          widget.stset(() {
            widget.selectedValue = value!;

            _selectedMenuValue = value;
          });
        });
  }
}
