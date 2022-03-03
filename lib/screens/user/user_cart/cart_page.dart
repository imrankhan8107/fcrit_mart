import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/screens/user/user_cart/get_cart_items.dart';
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
        title: const Text(
          'My Cart',
          style: TextStyle(fontSize: 30),
        ),
        leading: Appbarbutton(
          ontapAppbar: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GetCartItems(),
      // body: StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {  },),
    );
  }
}
