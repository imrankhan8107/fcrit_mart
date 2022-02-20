import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/screens/user/seller_side/my_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

var image, productName, description, mrp, price, productId;

class AllProductDetails extends StatelessWidget {
  const AllProductDetails({
    Key? key,
  }) : super(key: key);
  // final String type;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            var product = snapshot.data.docs;
            List<Widget> allProducts = [];
            for (var item in product) {
              image = item.data()['file'];
              productName = item.data()['Name'];
              description = item.data()['description'];
              mrp = item.data()['mrp'];
              price = item.data()['price'];
              productId = item.data()['id'];

              final tile = CardswithDetails(
                productname: productName,
                mrp: mrp.toString(),
                imageUrl: image,
                description: description,
                price: price.toString(),
                productId: productId,
              );
              allProducts.add(tile);
            }
            return ListView(
              children: allProducts,
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }
        return const Divider(height: 0);
      },
    );
  }
}

class GetCartItems extends StatelessWidget {
  const GetCartItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('Cart')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            var product = snapshot.data.docs;
            List<Widget> cartProducts = [];
            for (var item in product) {
              image = item.data()['imageUrl'];
              productName = item.data()['productName'];
              description = item.data()['description'];
              mrp = item.data()['mrp'];
              price = item.data()['price'];
              productId = item.data()['id'];

              final tile = CardswithDetails(
                productname: productName,
                mrp: mrp.toString(),
                imageUrl: image,
                description: description,
                price: price.toString(),
                productId: productId,
              );
              cartProducts.add(tile);
            }
            return ListView(
              children: cartProducts,
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }
        return const Divider(height: 0);
      },
    );
  }
}
