import 'package:flutter/material.dart';

class Textfieldinput extends StatelessWidget {
  const Textfieldinput({
    Key? key,
    required this.textEditingController,
    this.ispass = false,
    required this.hinttext,
    required this.textInputType,
    required this.maxlines,
    this.initialText,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final bool ispass;
  final String hinttext;
  final TextInputType textInputType;
  final int maxlines;
  final String? initialText;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
      borderRadius: BorderRadius.circular(10),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: TextFormField(
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return 'Please enter some value';
        //   }
        // },
        autofocus: true,
        initialValue: initialText,
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
