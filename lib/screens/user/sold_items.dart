import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'get_product_details.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SoldOutItems extends StatefulWidget {
  static const String id = 'sold_out_page';
  const SoldOutItems({Key? key}) : super(key: key);

  @override
  State<SoldOutItems> createState() => _SoldOutItemsState();
}

class _SoldOutItemsState extends State<SoldOutItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore
            .collection('order')
            .where('sellerId',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var items = snapshot.data.docs;
              List<Widget> myOrders = [];
              for (var item in items) {
                imageUrl = item.data()['imageUrl'];
                productName = item.data()['productName'];
                description = item.data()['description'];
                mrp = item.data()['mrp'];
                price = item.data()['price'];
                productId = item.data()['id'];
                ownerId = item.data()['ownerId'];

                final myOrderTile = ListTile(
                  title: Text(productName),
                );
                myOrders.add(myOrderTile);
              }
              return myOrders.isNotEmpty
                  ? Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'Sold Products',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      body: SafeArea(
                        child: ListView(
                          children: myOrders,
                        ),
                      ),
                    )
                  : Scaffold(
                      appBar: AppBar(
                        title: const Text(
                          'SOLD PRODUCTS',
                          style: TextStyle(fontSize: 30, fontFamily: 'Lobster'),
                        ),
                      ),
                      body: Center(
                        child: Text('NO PRODUCTS ARE CHECKED OUT YET'),
                      ),
                    );
            }
          }
          return Text('issue');
        },
      ),
    );
  }
}
