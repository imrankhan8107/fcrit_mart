import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/screens/user/seller_side/my_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

var imageUrl, productName, description, mrp, price, productId;

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
              imageUrl = item.data()['file'];
              productName = item.data()['Name'];
              description = item.data()['description'];
              mrp = item.data()['mrp'];
              price = item.data()['price'];
              productId = item.data()['id'];

              final tile = CardswithDetails(
                productname: productName,
                mrp: mrp.toString(),
                imageUrl: imageUrl,
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

Image getImage(String imageurl) {
  return Image.network(
    imageurl,
    filterQuality: FilterQuality.medium,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      }
      return CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      );
    },
  );
}

class GetCartItems extends StatelessWidget {
  GetCartItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalAmount = 0;
    return StreamBuilder(
      stream: _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('Cart')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 150,
            child: const CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            var product = snapshot.data.docs;
            List<Widget> cartProducts = [];
            for (var item in product) {
              imageUrl = item.data()['imageUrl'];
              productName = item.data()['productName'];
              description = item.data()['description'];
              mrp = item.data()['mrp'];
              price = item.data()['price'];
              productId = item.data()['id'];
              totalAmount = totalAmount + int.parse(price);
              print(totalAmount);

              final tile = Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: ListTile(
                    onTap: () {},
                    style: ListTileStyle.list,
                    leading: SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height,
                      child: getImage(imageUrl),
                    ),
                    title: Text(productName),
                    subtitle: Text(price),
                    // trailing: Icon(Icons.more_vert),
                    // isThreeLine: true,
                  ),
                ),
              );
              cartProducts.add(tile);
            }
            return ListView(
              children: cartProducts + [Text('Total Amount: $totalAmount')],
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
