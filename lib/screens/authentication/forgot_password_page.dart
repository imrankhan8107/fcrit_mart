import 'package:fcrit_mart/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController _emailid = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Please Enter Your Email Address'),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Textfieldinput(
                  textEditingController: _emailid,
                  hinttext: 'Enter your Email Address here',
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // FirebaseAuth.instance.confirmPasswordReset(code: , newPassword: newPassword)
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailid.text);
                      Fluttertoast.showToast(
                          msg: 'An Email Has been sent to reset password');
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print(e.code);
                        Fluttertoast.showToast(
                            msg: 'User Not Found.\nPlease Sign Up first.');
                      }
                    }
                  },
                  child: Text('Get Email to reset password'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
