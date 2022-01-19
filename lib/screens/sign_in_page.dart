import 'package:fcrit_mart/components/text_fields.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:flutter/material.dart';
import 'package:fcrit_mart/components/sign_in_options.dart';
import 'package:fcrit_mart/components/bottom_button.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Log in with one of the following options.',
                  style: kTextstyle,
                ),
                Row(
                  children: const [
                    SigninOptions(icon: Icons.g_mobiledata_outlined),
                    SigninOptions(icon: Icons.g_mobiledata),
                  ],
                ),
              ],
            ),
            const Credential(credentialname: 'E-mail'),
            const Credential(credentialname: 'Password'),
            BottomButton(
              buttontext: 'Log-in',
              text: 'Don\'t have an account?',
              textinbutton: 'Sign-up',
              onpress: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
