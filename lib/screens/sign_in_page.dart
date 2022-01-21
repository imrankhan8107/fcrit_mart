import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:fcrit_mart/components/sign_in_options.dart';
import 'package:fcrit_mart/components/bottom_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
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
                    await signIn(_emailField.text, _passwordField.text);
                if (shouldnavigate) {
                  Navigator.pushNamed(context, '/homepage');
                }
              },
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
