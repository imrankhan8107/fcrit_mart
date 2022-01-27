import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/bottom_button.dart';
import 'package:fcrit_mart/components/text_field.dart';
import 'package:fcrit_mart/flutterfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
            Navigator.pop(context);
          },
        ),
        title: const Text('Log in'),
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
            //       'Log in with one of the following options.',
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
            Image.asset('images/fcritlogo.png'),
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
                String shouldnavigate =
                    await signIn(_emailField.text, _passwordField.text);
                if (shouldnavigate == 'Yes') {
                  Navigator.pushNamed(context, '/homepage');
                }
              },
              buttontext: 'Log-in',
              text: 'Don\'t have an account?',
              textinbutton: 'Sign-up',
              ontextpress: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signInAnonymously();
                Navigator.pushNamed(context, '/homepage');
              },
              child: const Text('Sign in Anounymously'),
            )
          ],
        ),
      ),
    );
  }
}
