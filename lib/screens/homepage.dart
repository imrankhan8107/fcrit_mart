import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/screens/user/buyer_side/buyer_page.dart';
import 'package:fcrit_mart/screens/user/seller_side/seller_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = 'homepage_screen';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String usertype = 'Select';

  void usertypechoosen(context, String usertype) {
    if (usertype == 'Buyer') {
      Navigator.pushNamed(context, Buyerpage.id);
    } else if (usertype == 'Seller') {
      Navigator.pushNamed(context, Sellerpage.id);
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
            // exit(0);
            showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return const Dialogbox();
              },
            );
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
                      usertype = 'Select';
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
      body: Center(
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 5),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'images/fcritlogo.png',
                  height: MediaQuery.of(context).size.height / 3,
                ),
              ),
              const SizedBox(height: 30),
              AnimatedTextKit(
                animatedTexts: [
                  RotateAnimatedText('Welcome'),
                  RotateAnimatedText('To'),
                  ColorizeAnimatedText(
                    'Fcrit Mart',
                    speed: const Duration(seconds: 2),
                    colors: [
                      Colors.redAccent,
                      Colors.yellowAccent,
                      Colors.green,
                      Colors.pink,
                      Colors.orange,
                      Colors.lightBlueAccent,
                    ],
                    textStyle: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dialogbox extends StatefulWidget {
  const Dialogbox({Key? key}) : super(key: key);

  @override
  _DialogboxState createState() => _DialogboxState();
}

class _DialogboxState extends State<Dialogbox>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller.forward();

    animation = ColorTween(begin: Colors.indigoAccent, end: Colors.blueAccent)
        .animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.addListener(() {
      setState(() {});
      animation.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: animation.value,
      title: const Center(
        child:
            Text('Exit', style: TextStyle(color: Colors.black, fontSize: 30)),
      ),
      content: const Text('Do you want to exit?',
          style: TextStyle(color: Colors.black, fontSize: 18)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            controller.dispose();
            Navigator.of(context).pop();
          },
          child: const Text(
            'No',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () => exit(0),
          child: const Text('YES',
              style: TextStyle(color: Colors.amberAccent, fontSize: 16)),
        ),
      ],
    );
  }
}
