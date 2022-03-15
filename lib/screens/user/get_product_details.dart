import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool itemInOrders = false;

  Widget filterButton(String filterBy, String buttonText) {
    return TextButton(
      onPressed: () {
        setState(() {
          sortItemsBy = filterBy;
        });
      },
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 17),
      ),
    );
  }

  // void productInOrders(String id) async {
  //   bool containsItem =
  //       await _firestore.collection('order').snapshots().contains(id);
  //   setState(() {
  //     itemInOrders = containsItem;
  //     print(containsItem);
  //   });
  // }

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
                            filterButton('price', 'PRICE'),
                            filterButton('mrp', 'MRP'),
                            filterButton('publishTime', 'Time'),
                          ],
                        ),
                        bottomSheet: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              sortInDescending
                                  ? const Text(
                                      'Sorted in Descending',
                                    )
                                  : const Text('Sorted in Ascending'),
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
                        sortItemsBy.toUpperCase(),
                        style: const TextStyle(fontSize: 17),
                      ),
                      sortInDescending
                          ? const Icon(Icons.arrow_downward)
                          : const Icon(Icons.arrow_upward),
                    ],
                  ),
                ),
              )
            ];
            for (var item in product) {
              imageUrl = item.data()['file'];
              productName = item.data()['Name'];
              description = item.data()['description'];
              mrp = item.data()['mrp'];
              price = item.data()['price'];
              productId = item.data()['id'];
              ownerId = item.data()['owner'];
              var checkOut = item.data()['checkedOut'];
              if (checkOut == false && itemInOrders == false) {
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
            return allProducts.length > 1
                ? ListView(
                    children: allProducts,
                  )
                : const Center(
                    child: Text(
                    'No Items Added Yet',
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
        color: Colors.cyan,
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      );
    },
  );
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
