import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/screens/authentication/forgot_password_page.dart';
import 'package:fcrit_mart/screens/authentication/sign_in_page.dart';
import 'package:fcrit_mart/screens/authentication/sign_up_page.dart';
import 'package:fcrit_mart/screens/homepage.dart';
import 'package:fcrit_mart/screens/profile_page.dart';
import 'package:fcrit_mart/screens/settings_page.dart';
import 'package:fcrit_mart/screens/user/buyer_side/buyer_page.dart';
import 'package:fcrit_mart/screens/user/cart_page.dart';
import 'package:fcrit_mart/screens/user/seller_side/seller_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Fcritmart());
}

class Fcritmart extends StatefulWidget {
  const Fcritmart({Key? key}) : super(key: key);

  @override
  State<Fcritmart> createState() => _FcritmartState();
}

class _FcritmartState extends State<Fcritmart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignIn.id: (context) => const SignIn(),
        SignUp.id: (context) => const SignUp(),
        HomePage.id: (context) => const HomePage(),
        Buyerpage.id: (context) => const Buyerpage(),
        Sellerpage.id: (context) => const Sellerpage(),
        ForgotPass.id: (context) => const ForgotPass(),
        Settings.id: (context) => const Settings(),
        Profilepage.id: (context) => const Profilepage(),
        MyCart.id: (context) => const MyCart(),
      },
      theme: switchVal
          ? ThemeData.light()
          : ThemeData.dark().copyWith(
              appBarTheme: kDarkAppBarTheme,
              scaffoldBackgroundColor: kDarkBackgroundColor,
            ),
      // initialRoute: '/signup',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        // stream: FirebaseAuth.instance.idTokenChanges(),
        // stream: FirebaseAuth.instance.userChanges(),
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //ConnectionState is active means our connection with stream is active
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const HomePage();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.red,
            );
          }
          return const SignIn();
        },
      ),
    );
  }
}
