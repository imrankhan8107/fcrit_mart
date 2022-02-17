import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/screens/authentication/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Settings extends StatefulWidget {
  static const String id = 'settings_screen';
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String username = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void getusername() async {
    DocumentSnapshot snap = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
    print(username);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getusername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Appbarbutton(
          ontapAppbar: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignIn(),
                ),
                ModalRoute.withName(SignIn.id),
              );
            },
            child: Row(
              children: const [
                Text('Sign Out'),
                Icon(CupertinoIcons.square_arrow_left)
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: TextButton(
              onPressed: () {
                getusername();
              },
              child: Text(
                username,
                style: const TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: switchVal == false
                ? const Icon(FontAwesomeIcons.solidSun)
                : const Icon(FontAwesomeIcons.moon),
            title: const Text('App Theme'),
            trailing: Switch(
              value: switchVal,
              onChanged: (bool value) {
                setState(() {
                  switchVal = value;
                });
                print(switchVal);
              },
            ),
          )
        ],
      ),
    );
  }
}
