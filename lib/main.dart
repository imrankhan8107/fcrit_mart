import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/sign_in_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(Fcritmart());

class Fcritmart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: kAppBarTheme,
        scaffoldBackgroundColor: kScaffoldbackgroundcolor,
      ),
      home: SignIn(),
    );
  }
}
