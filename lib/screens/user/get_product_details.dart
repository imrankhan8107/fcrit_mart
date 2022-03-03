import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/item_card.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final FirebaseInAppMessaging firebaseInAppMessaging =
//     FirebaseInAppMessaging.instance;

var imageUrl, productName, description, mrp, price, productId, ownerId;

class AllProductDetails extends StatefulWidget {
  AllProductDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<AllProductDetails> createState() => _AllProductDetailsState();
}

class _AllProductDetailsState extends State<AllProductDetails> {
  bool sortInDescending = true;
  String sortItemsBy = 'price';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('products')
          .orderBy(sortItemsBy, descending: sortInDescending)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            var product = snapshot.data.docs;
            List<Widget> allProducts = [
              TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: const Text(
                              'Filter Options',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          body: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      sortItemsBy = 'price';
                                    });
                                  },
                                  child: const Text('price')),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      sortItemsBy = 'mrp';
                                    });
                                  },
                                  child: Text('mrp')),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      sortItemsBy = 'publishTime';
                                    });
                                  },
                                  child: Text('publishTime'))
                            ],
                          ),
                          bottomSheet: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                sortInDescending
                                    ? Text('Sorted in Descending')
                                    : Text('Sorted in Ascending'),
                                // Switch(
                                //     value: sortInDescending,
                                //     onChanged: (bool val) {
                                //       setState(() {
                                //         sortInDescending = val;
                                //       });
                                //     }),
                                CupertinoSwitch(
                                  value: sortInDescending,
                                  onChanged: (bool value) {
                                    setState(() {
                                      sortInDescending = value;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          sortItemsBy,
                          style: TextStyle(fontSize: 17),
                        ),
                        sortInDescending
                            ? Icon(Icons.arrow_downward)
                            : Icon(Icons.arrow_upward),
                      ],
                    ),
                  ))
            ];
            for (var item in product) {
              imageUrl = item.data()['file'];
              productName = item.data()['Name'];
              description = item.data()['description'];
              mrp = item.data()['mrp'];
              price = item.data()['price'];
              productId = item.data()['id'];
              ownerId = item.data()['owner'];

              final tile = CardswithDetails(
                productname: productName,
                mrp: mrp.toString(),
                imageUrl: imageUrl,
                description: description,
                price: price.toString(),
                productId: productId,
                ownerid: ownerId,
              );

              allProducts.add(tile);
            }
            // return GridView.count(
            //   clipBehavior: Clip.antiAlias,
            //   primary: false,
            //   padding: const EdgeInsets.all(20),
            //   crossAxisSpacing: 10,
            //   mainAxisSpacing: 10,
            //   crossAxisCount: 2,
            //   children: allProducts,
            // );
            return allProducts.isNotEmpty
                ? ListView(
                    children: allProducts,
                  )
                : const Center(
                    child: Text(
                    'Please Add Items',
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
    // print('CartItemCards');
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
                      child: const Text('View Item'),
                      onPressed: () {},
                    ),
                    CupertinoDialogAction(
                      child: const Text('Remove Item from Cart'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text('Remove?'),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text('Yes'),
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
                                  child: const Text('NO'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            );
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
