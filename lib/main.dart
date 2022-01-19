import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/screens/sign_in_page.dart';
import 'package:fcrit_mart/screens/sign_up_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(Fcritmart());

class Fcritmart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
      },
      initialRoute: '/signin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: kAppBarTheme,
        scaffoldBackgroundColor: kScaffoldbackgroundcolor,
      ),
    );
  }
}
