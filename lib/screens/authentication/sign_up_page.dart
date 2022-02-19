import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/components/bottom_button.dart';
import 'package:fcrit_mart/components/text_field.dart';
import 'package:fcrit_mart/flutterfire.dart';
import 'package:fcrit_mart/screens/authentication/sign_in_page.dart';
import 'package:fcrit_mart/screens/homepage.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  static const String id = 'sign_up_screen';
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
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Appbarbutton(
          ontapAppbar: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Sign up'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 15,
        ),
        children: [
          Column(
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
              const SizedBox(height: 10),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'images/fcritlogo.png',
                  height: MediaQuery.of(context).size.height / 4,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Textfieldinput(
                textEditingController: _name,
                hinttext: 'Enter your Name',
                textInputType: TextInputType.name,
                maxlines: 1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Textfieldinput(
                textEditingController: _mobilenumber,
                hinttext: 'Enter your Mobile number',
                textInputType: TextInputType.number,
                maxlines: 1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Textfieldinput(
                textEditingController: _emailField,
                hinttext: 'Enter your Email',
                textInputType: TextInputType.emailAddress,
                maxlines: 1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Textfieldinput(
                textEditingController: _passwordField,
                hinttext: 'Enter your Password',
                textInputType: TextInputType.text,
                ispass: true,
                maxlines: 1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              BottomButton(
                ontapbutton: () async {
                  String res = await Authmethods().signUpUser(
                    mobileno:
                        int.parse(_mobilenumber.text, onError: (String value) {
                      value = '';
                      return 0;
                    }),
                    password: _passwordField.text,
                    name: _name.text,
                    email: _emailField.text,
                  );
                  print(res);
                  if (res == 'Sign up Successful') {
                    Navigator.pushReplacementNamed(context, HomePage.id);
                  }
                },
                buttontext: 'Sign-up',
                text: 'Already have an account?',
                textinbutton: 'Log-in',
                ontextpress: () {
                  Navigator.pushReplacementNamed(context, SignIn.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// String shouldnavigate =
//     await signUp(_emailField.text, _passwordField.text);
// if (shouldnavigate == 'Yes') {
// Navigator.pushNamed(context, '/homepage');
// }
