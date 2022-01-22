import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kScaffoldbackgroundcolor = Color(0xFF101010);

const kAppBarTheme = AppBarTheme(
  toolbarHeight: 75,
  titleTextStyle: kAppbartitle,
  color: Color(0xFF101010),
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
        backgroundColor: kScaffoldbackgroundcolor,
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
            const ListTile(
              leading: Icon(CupertinoIcons.profile_circled),
              title: Text('Profile'),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.cart),
              title: Text('My cart'),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
