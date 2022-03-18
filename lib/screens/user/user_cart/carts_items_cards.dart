import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../see_product.dart';
import '../get_product_details.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CartItemCards extends StatefulWidget {
  const CartItemCards(
      {Key? key,
      required this.productname,
      required this.mrp,
      required this.imageUrl,
      required this.price,
      required this.description,
      required this.productId,
      required this.ownerId})
      : super(key: key);

  final String productname;
  final String ownerId;
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
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(widget.productname),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('View Item'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage(
                                  imageUrl: widget.imageUrl,
                                  productName: widget.productname,
                                  mrp: widget.mrp,
                                  price: widget.price,
                                  description: widget.description,
                                  id: widget.productId,
                                  ownerId: widget.ownerId)));
                    },
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
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 5,
                child: getImage(widget.imageUrl),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(widget.productname.toUpperCase()),
                    Text('PRICE: ' + widget.price)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
