import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/screens/user/get_product_details.dart';
import 'package:fcrit_mart/screens/user/seller_side/update_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyProductPopUp extends StatefulWidget {
  const MyProductPopUp({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.mrp,
    required this.price,
    required this.description,
    required this.id,
    required this.ownerId,
  }) : super(key: key);
  final String imageUrl;
  final String productName;
  final String mrp;
  final String price;
  final String description;
  final String id;
  final String ownerId;

  @override
  State<MyProductPopUp> createState() => _MyProductPopUpState();
}

class _MyProductPopUpState extends State<MyProductPopUp> {
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
            title: Text(
              widget.productName.toUpperCase(),
              style: TextStyle(fontSize: 20),
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
                        Text(
                          'PRICE :  ' + widget.price,
                          style: const TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 25,
                            // fontFamily: 'PermanentMarker',
                          ),
                        ),
                        Text(
                          'MRP :  ' + widget.mrp,
                          style: const TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 25,
                            // fontFamily: 'PermanentMarker',
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
                  onPressed: () {
                    // if(FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Cart').snapshots().con)
                    //TODO:add a new page inorder to make user able to update details
                    // FirebaseFirestore.instance
                    //     .collection('users')
                    //     .doc(FirebaseAuth.instance.currentUser?.uid)
                    //     .collection('Cart')
                    //     .doc(widget.id).update(data)
                    //     .set({
                    //   'productName': widget.productName,
                    //   'mrp': widget.mrp,
                    //   'imageUrl': widget.imageUrl,
                    //   'price': widget.price,
                    //   'description': widget.description,
                    //   'id': widget.id,
                    //   'ownerId': widget.ownerId,
                    // });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateItemDetails(
                                  description: widget.description,
                                  price: widget.price,
                                  imageUrl: widget.imageUrl,
                                  productName: widget.productName,
                                  mrp: widget.mrp,
                                  ownerId: widget.ownerId,
                                  productId: widget.id,
                                )));
                  },
                  child: const Text(
                    'Update details',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          // return AlertDialog(
                          //   title:
                          //       Text('Do you really want\n to delete the Item'),
                          //   actions: [
                          //     TextButton(onPressed: () {}, child: Text('Yes')),
                          //     TextButton(onPressed: () {}, child: Text('NO'))
                          //   ],
                          // );
                          return CupertinoAlertDialog(
                            title: const Text(
                              'Do you really want\n to delete the Item',
                            ),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('Yes'),
                                onPressed: () {
                                  try {
                                    FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(widget.id)
                                        .delete();
                                    Fluttertoast.showToast(
                                        msg: 'Item deleted successfully');
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    print(e);
                                    Fluttertoast.showToast(
                                        msg: 'Item deletion unsuccessful');
                                  }
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text('NO'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: const Text(
                    'Delete Item',
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
