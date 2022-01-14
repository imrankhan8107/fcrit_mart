import 'package:flutter/material.dart';
import 'package:fcrit_mart/components/appbar_leading_button.dart';
import 'package:fcrit_mart/components/sign_in_options.dart';
import 'package:fcrit_mart/components/bottom_button.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Appbarbutton(),
        title: const Text('Log in'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sign up with one of the following options.'),
            Row(
              children: [
                SigninOptions(icon: Icons.g_mobiledata_outlined),
                SigninOptions(icon: Icons.g_mobiledata),
              ],
            ),
            Credential(credentialname: 'Name'),
            Credential(credentialname: 'E-mail'),
            Credential(credentialname: 'Password'),
            BottomButton(
              buttontext: 'Create Account',
            ),
          ],
        ),
      ),
    );
  }
}

class Credential extends StatefulWidget {
  final String credentialname;
  Credential({required this.credentialname});

  @override
  State<Credential> createState() => _CredentialState();
}

class _CredentialState extends State<Credential> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.credentialname),
        TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            hintText: 'Enter your ${widget.credentialname}',
          ),
        ),
      ],
    );
  }
}
