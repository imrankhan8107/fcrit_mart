import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'get_product_details.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class MyOrders extends StatefulWidget {
  static const String id = 'my_order_page';
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  String name = '';
  String email = '';
  int mobilenumber = 0000000000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore
            .collection('order')
            .where('buyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                productId = item.data()['productId'];
                var sellerId = item.data()['sellerId'];
                var ownerId = item.data()['buyerId'];

                final myOrderTile = ListTile(
                  title: Text(productName),
                  onTap: () async {
                    DocumentSnapshot documentSnapshot = await _firestore
                        .collection('users')
                        .doc(sellerId)
                        .get();
                    var snap = documentSnapshot.data() as Map<String, dynamic>;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text('Seller Details'),
                          actions: [
                            CupertinoDialogAction(
                              onPressed: () {},
                              child: Text(snap['username']),
                            ),
                            CupertinoDialogAction(
                              onPressed: () {
                                launch(
                                    'https://www.gmail.com${snap['email'].toString()}');
                              },
                              child: Text(snap['email']),
                            ),
                            CupertinoDialogAction(
                              child: Text(snap['mobileno'].toString()),
                              onPressed: () {
                                launch(
                                    'https://wa.me/+91${snap['mobileno'].toString()}');
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                );
                myOrders.add(myOrderTile);
              }
              return myOrders.isNotEmpty
                  ? Scaffold(
                      appBar: AppBar(
                        title: Text('My Orders'),
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
                          'Order Page',
                          style: TextStyle(fontSize: 30, fontFamily: 'Lobster'),
                        ),
                      ),
                      body: Center(
                        child: Text('NO PRODUCTS ARE CHECKED OUT YET'),
                      ),
                    );
            }
          }
          return Center(child: Text('issue'));
        },
      ),
    );
  }
}
