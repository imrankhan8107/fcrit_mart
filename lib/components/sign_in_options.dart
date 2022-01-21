import 'package:flutter/material.dart';

class SigninOptions extends StatelessWidget {
  final IconData icon;
  const SigninOptions({Key? key, required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 50,
          ),
        ),
      ),
    );
  }
}
