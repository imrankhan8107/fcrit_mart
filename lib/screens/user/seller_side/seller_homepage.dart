import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/screens/user/get_product_details.dart';
import 'package:fcrit_mart/screens/user/seller_side/my_products.dart';
import 'package:flutter/material.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Myproducts extends StatefulWidget {
  const Myproducts({Key? key}) : super(key: key);

  @override
  State<Myproducts> createState() => _MyproductsState();
}

class _MyproductsState extends State<Myproducts> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Appbarbutton(
            ontapAppbar: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Seller page',
            style: TextStyle(fontSize: 18),
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'All products',
              ),
              Tab(
                text: 'My Items',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllProductDetails(),
            const MyItems(),
          ],
        ),
      ),
    );
  }
}
