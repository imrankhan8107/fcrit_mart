import 'dart:io';

import 'package:fcrit_mart/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/bottom_button.dart';
import 'package:fcrit_mart/components/sign_in_options.dart';
import 'package:fcrit_mart/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Appbarbutton(
          ontapAppbar: () {
            exit(0);
          },
        ),
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
                  children: const [
                    SigninOptions(icon: Icons.g_mobiledata_outlined),
                    SigninOptions(icon: Icons.g_mobiledata),
                  ],
                ),
              ],
            ),
            // const Credential(credentialname: 'Name'),
            TextFormField(
              controller: _emailField,
              decoration: const InputDecoration(
                hintText: 'something@gmail.com',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                labelText: 'E-mail',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            TextFormField(
              controller: _passwordField,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'password',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            BottomButton(
              ontapbutton: () async {
                bool shouldnavigate =
                    await signUp(_emailField.text, _passwordField.text);
                if (shouldnavigate) {
                  Navigator.pushNamed(context, '/homepage');
                }
              },
              buttontext: 'Sign-up',
              text: 'Already have an account?',
              textinbutton: 'Log-in',
              onpress: () {
                Navigator.pushNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
    );
  }
}
