import 'package:flutter/material.dart';

class SigninOptions extends StatelessWidget {
  final IconData icon;
  SigninOptions({required this.icon});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 50,
          ),
        ),
      ),
    );
  }
}
