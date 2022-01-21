import 'package:flutter/material.dart';

class Appbarbutton extends StatefulWidget {
  const Appbarbutton({Key? key}) : super(key: key);

  @override
  _AppbarbuttonState createState() => _AppbarbuttonState();
}

class _AppbarbuttonState extends State<Appbarbutton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        foregroundDecoration: const BoxDecoration(),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.arrow_back_ios_rounded),
      ),
    );
  }
}
