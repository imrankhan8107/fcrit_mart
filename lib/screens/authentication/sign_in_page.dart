import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/bottom_button.dart';
import 'package:fcrit_mart/components/text_field.dart';
import 'package:fcrit_mart/flutterfire.dart';
import 'package:fcrit_mart/screens/authentication/forgot_password_page.dart';
import 'package:fcrit_mart/screens/authentication/sign_up_page.dart';
import 'package:fcrit_mart/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';

class SignIn extends StatefulWidget {
  static const String id = 'sign_in_screen';

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
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Appbarbutton(
          ontapAppbar: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return const Dialogbox();
              },
            );
          },
        ),
        title: const Text('Log in'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        children: [
          Column(
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
              const SizedBox(height: 5),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'images/fcritlogo.png',
                  height: MediaQuery.of(context).size.height / 3,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Textfieldinput(
                textEditingController: _emailField,
                hinttext: 'Enter your Email',
                textInputType: TextInputType.emailAddress,
                maxlines: 1,
              ),
              // SizedBox(height: MediaQuery.of(context).size.height / 60),
              Textfieldinput(
                textEditingController: _passwordField,
                hinttext: 'Enter your Password',
                textInputType: TextInputType.text,
                ispass: true,
                maxlines: 1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              BottomButton(
                ontapbutton: () async {
                  String shouldnavigate =
                      await signIn(_emailField.text, _passwordField.text);
                  if (shouldnavigate == 'Yes') {
                    showSnackBar('Sign-in Success', context);
                    Navigator.pushReplacementNamed(context, HomePage.id);
                  } else {
                    Fluttertoast.showToast(msg: shouldnavigate);
                  }
                },
                buttontext: 'Log-in',
                text: 'Don\'t have an account?',
                textinbutton: 'Sign-up',
                ontextpress: () {
                  Navigator.pushNamed(context, SignUp.id);
                },
              ),

              TextButton(
                onPressed: () async {
                  Navigator.pushNamed(context, ForgotPass.id);
                },
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
