import 'package:flutter/material.dart';

class Credential extends StatelessWidget {
  final String credentialname;
  Credential({required this.credentialname});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          credentialname,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            hintText: 'Enter your $credentialname',
          ),
        ),
      ],
    );
  }
}
