import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:flutter/material.dart';

class Sellerpage extends StatefulWidget {
  const Sellerpage({Key? key}) : super(key: key);

  @override
  State<Sellerpage> createState() => _SellerpageState();
}

class _SellerpageState extends State<Sellerpage> {
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
        title: const Text('Hello Seller'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) {
          setState(() {
            itemno = value;
          });
        },
        currentIndex: itemno,
        selectedItemColor: Colors.orange,
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
