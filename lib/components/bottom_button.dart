import 'package:fcrit_mart/constants.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton(
      {Key? key,
      required this.buttontext,
      required this.text,
      required this.textinbutton,
      required this.ontextpress,
      required this.ontapbutton})
      : super(key: key);
  final String buttontext;
  final String text;
  final String textinbutton;
  final void Function() ontextpress;
  final void Function() ontapbutton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: ontapbutton,
          child: Container(
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
            width: double.infinity,
            height: 60,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: kTextstyle,
            ),
            TextButton(
              onPressed: ontextpress,
              child: Text(textinbutton),
            )
          ],
        ),
      ],
    );
  }
}
