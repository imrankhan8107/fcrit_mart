import 'package:fcrit_mart/constants.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    required this.buttontext,
    required this.text,
    required this.textinbutton,
    required this.onpress,
  });
  final String buttontext;
  final String text;
  final String textinbutton;
  final void Function() onpress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: kGradientcolor,
          ),
          child: Center(
            child: Text(
              buttontext,
              style: kBottomButtonStyle,
            ),
          ),
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          height: 80,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: kTextstyle,
            ),
            TextButton(
              onPressed: onpress,
              child: Text(textinbutton),
            )
          ],
        ),
      ],
    );
  }
}
