import 'dart:io';

import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/bottom_button.dart';
import 'package:fcrit_mart/components/text_field.dart';
import 'package:fcrit_mart/flutterfire.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobilenumber = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mobilenumber.dispose();
    _name.dispose();
    _emailField.dispose();
    _passwordField.dispose();
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Text(
            //       'Sign up with one of the following options.',
            //       style: kTextstyle,
            //     ),
            //     Row(
            //       children: const [
            //         SigninOptions(icon: Icons.g_mobiledata_outlined),
            //         SigninOptions(icon: Icons.g_mobiledata),
            //       ],
            //     ),
            //   ],
            // ),
            // const Credential(credentialname: 'Name'),
            Image.asset(
              'images/fcritlogo.png',
              height: 200,
            ),
            Textfieldinput(
              textEditingController: _name,
              hinttext: 'Enter your Name',
              textInputType: TextInputType.name,
            ),
            Textfieldinput(
              textEditingController: _mobilenumber,
              hinttext: 'Enter your Mobile number',
              textInputType: TextInputType.number,
            ),
            Textfieldinput(
              textEditingController: _emailField,
              hinttext: 'Enter your Email',
              textInputType: TextInputType.emailAddress,
            ),
            Textfieldinput(
              textEditingController: _passwordField,
              hinttext: 'Enter your Password',
              textInputType: TextInputType.text,
              ispass: true,
            ),
            BottomButton(
              ontapbutton: () async {
                String res = await Authmethods().signUpUser(
                  mobileno: _mobilenumber.text,
                  password: _passwordField.text,
                  name: _name.text,
                  email: _emailField.text,
                );
                print(res);
                if (res == 'success') {
                  Navigator.pushNamed(context, '/homepage');
                }
              },
              buttontext: 'Sign-up',
              text: 'Already have an account?',
              textinbutton: 'Log-in',
              ontextpress: () {
                Navigator.pushNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// String shouldnavigate =
//     await signUp(_emailField.text, _passwordField.text);
// if (shouldnavigate == 'Yes') {
// Navigator.pushNamed(context, '/homepage');
// }
