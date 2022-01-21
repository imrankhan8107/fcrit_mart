import 'package:fcrit_mart/constants.dart';
import 'package:flutter/material.dart';

class Appbarbutton extends StatelessWidget {
  const Appbarbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          gradient: kGradientcolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.arrow_back_ios_rounded),
      ),
    );
  }
}
