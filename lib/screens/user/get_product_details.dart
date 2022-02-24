import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/screens/user/seller_side/my_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
    return StreamBuilder(
      stream: _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('Cart')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              height: 150,
              width: 150,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            var product = snapshot.data.docs;
            List<Widget> cartProducts = [];
            int totalAmount = 0;
            for (var item in product) {
              imageUrl = item.data()['imageUrl'];
              productName = item.data()['productName'];
              description = item.data()['description'];
              mrp = item.data()['mrp'];
              price = item.data()['price'];
              productId = item.data()['id'];
              totalAmount = totalAmount + int.parse(price);
              print(totalAmount);

              final tile = CartItemCards(
                productname: productName,
                mrp: mrp,
                imageUrl: imageUrl,
                price: price,
                description: description,
                productId: productId,
              );
              cartProducts.add(tile);
            }
            return ListView(
              children: cartProducts +
                  [
                    totalAmount != 0
                        ? Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 150, bottom: 20),
                                  child: Text(
                                    'Total Amount: $totalAmount',
                                    style: const TextStyle(
                                      fontFamily: 'Lobster',
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 30),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('PROCEED TO CHECKOUT'),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height / 3,
                                horizontal:
                                    MediaQuery.of(context).size.width / 5),
                            child: const Text(
                              'No items added to Cart yet',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                  ],
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

class CartItemCards extends StatefulWidget {
  const CartItemCards({
    Key? key,
    required this.productname,
    required this.mrp,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.productId,
  }) : super(key: key);

  final String productname;
  final String mrp;
  final String price;
  final String imageUrl;
  final String description;
  final String productId;

  @override
  State<CartItemCards> createState() => _CartItemCardsState();
}

class _CartItemCardsState extends State<CartItemCards> {
  @override
  Widget build(BuildContext context) {
    print('CartItemCards');
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: ListTile(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(widget.productname),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('View Item'),
                        onPressed: () {},
                      ),
                      CupertinoDialogAction(
                        child: Text('Remove Item from Cart'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text('Remove?'),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        //TODO: remove item from cart
                                        _firestore
                                            .collection('users')
                                            .doc(FirebaseAuth
                                                .instance.currentUser?.uid)
                                            .collection('Cart')
                                            .doc(widget.productId)
                                            .delete();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text('NO'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  );
                });
          },
          style: ListTileStyle.list,
          leading: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height,
            child: getImage(widget.imageUrl),
          ),
          title: Text(widget.productname),
          subtitle: Text(widget.price),
          // trailing: Icon(Icons.more_vert),
          // isThreeLine: true,
        ),
      ),
    );
  }
}

// showCupertinoModalPopup(
// context: context,
// builder: (context) {
// return BottomPopup(
// imageUrl: widget.imageUrl,
// productName: widget.productname,
// mrp: widget.mrp,
// price: widget.price,
// description: widget.description,
// id: widget.productId,
// );
// },
// );
