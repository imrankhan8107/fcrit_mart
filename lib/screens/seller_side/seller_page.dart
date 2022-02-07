import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/screens/seller_side/my_products.dart';
import 'package:flutter/material.dart';

import 'add_product.dart';

class Sellerpage extends StatefulWidget {
  const Sellerpage({Key? key}) : super(key: key);

  @override
  State<Sellerpage> createState() => _SellerpageState();
}

class _SellerpageState extends State<Sellerpage> {
  int mrp = 0;
  int price = 0;
  int _selectedIndex = 0;
  TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      const Myproducts(),
      const AddProducts(),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const AppDrawer(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
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
        ],
      ),
    );
  }
}
