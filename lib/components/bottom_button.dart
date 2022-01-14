import 'package:fcrit_mart/constants.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String buttontext;
  BottomButton({required this.buttontext});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [Color(0xFFB515DF), Color(0xFFD127A4)]),
      ),
      child: Center(
        child: Text(
          buttontext,
          style: kBottomButtonStyle,
        ),
      ),
      margin: EdgeInsets.all(10),
      width: double.infinity,
      height: 80,
    );
  }
}
