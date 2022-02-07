import 'dart:io';

import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String usertype = 'Select';

  void usertypechoosen(context, String usertype) {
    if (usertype == 'Buyer') {
      Navigator.pushNamed(context, '/buyerpage');
    } else if (usertype == 'Seller') {
      Navigator.pushNamed(context, '/sellerpage');
    } else {
      usertype = 'Select';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: Appbarbutton(
          ontapAppbar: () {
            exit(0);
          },
        ),
        actions: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: usertype,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 10,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (String? newValue) {
                    setState(() {
                      usertype = newValue!;
                      usertypechoosen(context, usertype);
                      setState(() {
                        usertype = 'Select';
                      });
                    });
                  },
                  items: <String>['Select', 'Buyer', 'Seller']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to FCRIT MART',
          style: kHomepageTextStyle,
        ),
      ),
    );
  }
}
