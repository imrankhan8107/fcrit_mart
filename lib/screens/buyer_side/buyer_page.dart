import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/screens/buyer_side/buyer_side_view.dart';
import 'package:flutter/material.dart';

class Buyerpage extends StatefulWidget {
  static const String id = 'buyer_page_screen';
  const Buyerpage({Key? key}) : super(key: key);

  @override
  State<Buyerpage> createState() => _BuyerpageState();
}

class _BuyerpageState extends State<Buyerpage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const BuyersideHomepage(),
    const Center(
      child: Text('Items Added to cart will be displayed here'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My Cart',
          ),
        ],
      ),
    );
  }
}
