import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/text_field.dart';
import 'package:fcrit_mart/screens/authentication/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPass extends StatefulWidget {
  static const String id = 'forgot_pass_screen';
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController _emailid = TextEditingController();
  // final TextEditingController _resetcode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // bool showCodeInputBox = false;
    return Scaffold(
      appBar: AppBar(
        leading: Appbarbutton(
          ontapAppbar: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      'Please Enter Your Email Address',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Textfieldinput(
                      textEditingController: _emailid,
                      hinttext: 'Enter your Email Address here',
                      textInputType: TextInputType.emailAddress,
                      maxlines: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // FirebaseAuth.instance.confirmPasswordReset(code: , newPassword: newPassword)
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: _emailid.text);
                          // FirebaseAuth.instance.checkActionCode()
                          Fluttertoast.showToast(
                              msg: 'An Email Has been sent to reset password');
                          Navigator.pushReplacementNamed(context, SignIn.id);
                          Fluttertoast.showToast(
                              msg: 'You are redirected to Log in page');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print(e.code);
                            Fluttertoast.showToast(
                                backgroundColor: Colors.blueGrey,
                                textColor: Colors.cyanAccent,
                                msg: 'User Not Found.\nPlease Sign Up first.');
                          }
                        }
                      },
                      child: const Text('Get Email to reset password'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
