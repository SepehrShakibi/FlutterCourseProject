import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncomeBox extends StatelessWidget {
  final Widget icon;
  final String count;

  const IncomeBox({required this.icon, required this.count});
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
            Expanded(flex: 2, child: icon),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_upward,
                    size: 30,
                    color: Color.fromARGB(255, 169, 246, 81),
                  ),
                  Text(
                    "+$count",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'CharisSILB',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 169, 246, 81)),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
