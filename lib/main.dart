import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/screens/authentication/forgot_password_page.dart';
import 'package:fcrit_mart/screens/authentication/sign_in_page.dart';
import 'package:fcrit_mart/screens/authentication/sign_up_page.dart';
import 'package:fcrit_mart/screens/buyer_side/buyer_page.dart';
import 'package:fcrit_mart/screens/homepage.dart';
import 'package:fcrit_mart/screens/seller_side/seller_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Fcritmart());
}

class Fcritmart extends StatelessWidget {
  const Fcritmart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/signin': (context) => const SignIn(),
        '/signup': (context) => const SignUp(),
        '/homepage': (context) => const HomePage(),
        '/buyerpage': (context) => const Buyerpage(),
        '/sellerpage': (context) => const Sellerpage(),
        '/forgotpass': (context) => const ForgotPass(),
      },
      initialRoute: '/signup',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: kAppBarTheme,
        scaffoldBackgroundColor: kScaffoldbackgroundcolor,
      ),
    );
  }
}
