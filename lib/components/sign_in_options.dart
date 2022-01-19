import 'package:flutter/material.dart';

class SigninOptions extends StatelessWidget {
  final IconData icon;
  const SigninOptions({required this.icon});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
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
