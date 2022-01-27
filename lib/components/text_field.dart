import 'package:flutter/material.dart';

class Textfieldinput extends StatelessWidget {
  const Textfieldinput({
    Key? key,
    required this.textEditingController,
    this.ispass = false,
    required this.hinttext,
    required this.textInputType,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final bool ispass;
  final String hinttext;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextFormField(
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return 'Please enter some value';
      //   }
      // },
      controller: textEditingController,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        hintText: hinttext,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(15),
      ),
      obscureText: ispass,
      keyboardType: textInputType,
    );
  }
}
