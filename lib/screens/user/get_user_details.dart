import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/screens/user/seller_side/my_products.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AllProductDetails extends StatelessWidget {
  const AllProductDetails({Key? key}) : super(key: key);

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
              final image = item.data()['file'];
              final productName = item.data()['Name'];
              final description = item.data()['description'];
              final mrp = item.data()['mrp'];
              final price = item.data()['price'];

              final tile = CardswithDetails(
                  title: productName,
                  subtitle: mrp.toString(),
                  imageUrl: image);
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
