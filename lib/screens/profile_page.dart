import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  String Name = '';
  String email = '';
  int mobilenumber = 0000000000;

  ListTile detailsinRow(IconData icon, String detailName, String detail) {
    return ListTile(
      leading: Icon(icon),
      title: Text(detailName),
      trailing: Text(detail),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetails();
  }

  void userDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    // var snapshot = snap.data() as Map<String, dynamic>;
    print(snap.data());
    var snapshot = snap.data() as Map<String, dynamic>;
    setState(() {
      email = snapshot['email'];
      mobilenumber = snapshot['mobileno'];
      Name = snapshot['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Information',
          style: TextStyle(fontSize: 30),
        ),
        leading: Appbarbutton(
          ontapAppbar: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            detailsinRow(CupertinoIcons.person_crop_circle, 'Name', Name),
            detailsinRow(CupertinoIcons.mail_solid, 'Email', email),
            detailsinRow(
                FontAwesomeIcons.mobile, 'Mobile Number', '+91$mobilenumber'),
          ],
        ),
      ),
    );
  }
}
