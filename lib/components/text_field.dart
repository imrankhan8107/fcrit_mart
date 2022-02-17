import 'package:flutter/material.dart';

class Textfieldinput extends StatelessWidget {
  const Textfieldinput({
    Key? key,
    required this.textEditingController,
    this.ispass = false,
    required this.hinttext,
    required this.textInputType,
    required this.maxlines,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final bool ispass;
  final String hinttext;
  final TextInputType textInputType;
  final int maxlines;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: TextFormField(
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return 'Please enter some value';
        //   }
        // },
        maxLines: maxlines,
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
      ),
    );
  }
}
