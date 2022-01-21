import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:flutter/material.dart';

class Sellerpage extends StatelessWidget {
  const Sellerpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Appbarbutton(),
        title: const Text('Hello Seller'),
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
            icon: Icon(Icons.add_circle),
            label: 'Add',
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
