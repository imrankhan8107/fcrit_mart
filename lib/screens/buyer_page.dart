import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:flutter/material.dart';

class Buyerpage extends StatefulWidget {
  const Buyerpage({Key? key}) : super(key: key);

  @override
  State<Buyerpage> createState() => _BuyerpageState();
}

class _BuyerpageState extends State<Buyerpage> {
  int itemno = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: Appbarbutton(
          ontapAppbar: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Hello Buyer'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: itemno,
        onTap: (int value) {
          setState(() {
            itemno = value;
          });
        },
        selectedItemColor: Colors.orange,
        enableFeedback: true,
        // TODO: Set selected tab bar
        // 6
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
