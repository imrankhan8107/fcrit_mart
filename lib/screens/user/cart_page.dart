import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:flutter/material.dart';

class MyCart extends StatefulWidget {
  static const String id = 'user_cart';
  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Appbarbutton(
          ontapAppbar: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text('Cart Page'),
      ),
    );
  }
}
