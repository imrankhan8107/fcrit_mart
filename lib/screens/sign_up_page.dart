import 'package:fcrit_mart/components/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/bottom_button.dart';
import 'package:fcrit_mart/components/sign_in_options.dart';
import 'package:fcrit_mart/constants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Appbarbutton(),
        title: const Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sign up with one of the following options.',
                  style: kTextstyle,
                ),
                Row(
                  children: [
                    SigninOptions(icon: Icons.g_mobiledata_outlined),
                    SigninOptions(icon: Icons.g_mobiledata),
                  ],
                ),
              ],
            ),
            Credential(credentialname: 'Name'),
            Credential(credentialname: 'E-mail'),
            Credential(credentialname: 'Password'),
            BottomButton(
              buttontext: 'Sign-up',
              text: 'Already have an account?',
              textinbutton: 'Log-in',
              onpress: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
