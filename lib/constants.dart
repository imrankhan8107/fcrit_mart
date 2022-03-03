import 'package:fcrit_mart/screens/profile_page.dart';
import 'package:fcrit_mart/screens/settings_page.dart';
import 'package:fcrit_mart/screens/user/user_cart/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}

bool switchVal = false;

var kAppBarTheme = kLightAppBarTheme;
var kScaffoldbackgroundcolor = kLightBackgroundColor;
const kDarkBackgroundColor = Color(0xFF101010);
const kLightBackgroundColor = Color(0xFFFFFFFF);
const kLightAppBarTheme = AppBarTheme(
  toolbarHeight: 75,
  titleTextStyle: kAppbartitle,
  color: Color(0xFFFFFFFF),
);
const kDarkAppBarTheme = AppBarTheme(
  toolbarHeight: 75,
  titleTextStyle: kAppbartitle,
  color: Color(0xFF101010),
);

const kHomepageTextStyle = TextStyle(
  fontSize: 80,
  fontFamily: 'Lobster',
  color: Colors.cyan,
);
const kTextstyle = TextStyle(
  fontSize: 15,
  color: Color(0xFFA4A4A4),
);
const kAppbartitle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
);
const kBottomButtonStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const kGradientcolor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.topRight,
  colors: [Color(0xFFB515DF), Color(0xFFD127A4)],
);

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: kDarkBackgroundColor,
        child: Column(
          children: [
            Container(
              child: Center(
                  child: Text(
                'FCRIT Mart',
                style: kBottomButtonStyle.copyWith(
                  fontSize: 30,
                ),
              )),
              decoration: const BoxDecoration(gradient: kGradientcolor),
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.profile_circled),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, Profilepage.id);
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.cart_fill),
              title: const Text('My cart'),
              onTap: () {
                Navigator.pushNamed(context, MyCart.id);
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, Settings.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
