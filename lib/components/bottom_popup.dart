import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/screens/see_product.dart';
import 'package:fcrit_mart/screens/user/get_product_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class BottomPopup extends StatefulWidget {
  const BottomPopup(
      {Key? key,
      required this.imageUrl,
      required this.productName,
      required this.mrp,
      required this.price,
      required this.description,
      required this.id,
      required this.ownerId})
      : super(key: key);
  final String imageUrl;
  final String productName;
  final String mrp;
  final String price;
  final String description;
  final String id;
  final String ownerId;

  @override
  State<BottomPopup> createState() => _BottomPopupState();
}

class _BottomPopupState extends State<BottomPopup>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Scaffold(
          backgroundColor: kScaffoldbackgroundcolor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          bottomSheet: BottomSheet(
            onClosing: () {
              Navigator.of(context).pop();
            },
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: getImage(widget.imageUrl),
                      ),
                    ),
                    // Text('Owner: ${widget.ownerId}'),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Product Name : ',
                            style: TextStyle(
                                fontSize: 18, color: Colors.lightBlueAccent),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.productName,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 30,
                              fontFamily: 'PermanentMarker',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'PRICE :  ' + widget.price,
                            style: const TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 25,
                              // fontFamily: 'PermanentMarker',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'MRP :  ' + widget.mrp,
                            style: const TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 25,
                              // fontFamily: 'PermanentMarker',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: Container(
            color: kDarkBackgroundColor,
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // if(FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Cart').snapshots().con)
                    // productId = widget.id;
                    if (widget.ownerId !=
                        FirebaseAuth.instance.currentUser?.uid) {
                      // if (await _firestore
                      //     .collection('products')
                      //     .snapshots()
                      //     .contains(widget.id)) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.height / 2,
                              child: Center(
                                  child: SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: CircularProgressIndicator())));
                        },
                      );
                      await _firestore
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection('Cart')
                          .doc(widget.id)
                          .set({
                        'productName': widget.productName,
                        'mrp': widget.mrp,
                        'imageUrl': widget.imageUrl,
                        'price': widget.price,
                        'description': widget.description,
                        'id': widget.id,
                        'ownerId': widget.ownerId,
                      });
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                          msg: 'Item Added to cart Successfully');
                      // } else {
                      //   Fluttertoast.showToast(
                      //       msg: 'Item Has been deleted by the user');
                      // }
                    } else {
                      Fluttertoast.showToast(
                          msg: "You cannot add your own product to cart");
                    }
                  },
                  child: const Text(
                    'ADD TO CART',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductPage(
                              imageUrl: widget.imageUrl,
                              productName: widget.productName,
                              mrp: widget.mrp,
                              price: widget.price,
                              description: widget.description,
                              id: widget.id,
                              ownerId: widget.ownerId);
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'See the item',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
