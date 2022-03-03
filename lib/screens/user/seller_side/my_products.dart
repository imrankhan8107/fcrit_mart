import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/screens/user/get_product_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'myproducts_cards.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class MyItems extends StatefulWidget {
  const MyItems({Key? key}) : super(key: key);

  @override
  State<MyItems> createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('products')
          .where('owner', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            var product = snapshot.data.docs;
            List<Widget> myProducts = [];
            for (var item in product) {
              imageUrl = item.data()['file'];
              productName = item.data()['Name'];
              description = item.data()['description'];
              mrp = item.data()['mrp'];
              price = item.data()['price'];
              productId = item.data()['id'];
              ownerId = item.data()['owner'];

              final tile = MyProductCards(
                productname: productName,
                mrp: mrp.toString(),
                imageUrl: imageUrl,
                description: description,
                price: price.toString(),
                productId: productId,
                ownerid: ownerId,
              );

              myProducts.add(tile);
            }
            // return GridView.count(
            //   clipBehavior: Clip.antiAlias,
            //   primary: false,
            //   padding: const EdgeInsets.all(20),
            //   crossAxisSpacing: 10,
            //   mainAxisSpacing: 10,
            //   crossAxisCount: 2,
            //   children: myProducts,
            // );
            return myProducts.isNotEmpty
                ? ListView(
                    children: myProducts,
                  )
                : const Center(
                    child: Text(
                    'You have not uploaded and items',
                    style: TextStyle(fontSize: 25, fontFamily: 'Lobster'),
                  ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }
        return const Divider(height: 0);
      },
    );
  }
}
