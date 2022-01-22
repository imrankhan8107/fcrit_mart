import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:flutter/material.dart';

class Buyerpage extends StatelessWidget {
  const Buyerpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Appbarbutton(
          ontapAppbar: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Hello Buyer'),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
