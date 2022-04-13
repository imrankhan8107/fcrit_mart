import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductPage extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final String mrp;
  final String price;
  final String description;
  final String id;
  final String ownerId;

  const ProductPage(
      {Key? key,
      required this.imageUrl,
      required this.productName,
      required this.mrp,
      required this.price,
      required this.description,
      required this.id,
      required this.ownerId})
      : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    double percentSave = (int.parse(widget.mrp) - int.parse(widget.price)) /
        int.parse(widget.mrp) *
        100;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productName,
          style: const TextStyle(
            letterSpacing: 2,
            fontFamily: 'PermanentMarker',
            fontSize: 25,
          ),
        ),
        leading: Appbarbutton(
          ontapAppbar: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          Image.network(
            widget.imageUrl,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                'PRODUCT NAME:    ',
                style: const TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 18,
                    fontFamily: 'Lobster',
                    letterSpacing: 2),
              ),
              Expanded(
                  child: Text(
                widget.productName.toUpperCase(),
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'PermanentMarker',
                    color: Colors.lightBlueAccent),
              ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Price:  ' + widget.price,
              style: const TextStyle(
                  fontSize: 25,
                  fontFamily: 'Lobster',
                  color: Colors.redAccent)),
          const SizedBox(
            height: 10,
          ),
          Text('MRP:  ' + widget.mrp,
              style: const TextStyle(
                  fontSize: 25,
                  fontFamily: 'Lobster',
                  color: Colors.lightGreenAccent)),
          const SizedBox(
            height: 10,
          ),
          Text(
            'You Saved: ${percentSave.toStringAsFixed(2)}%',
            style: TextStyle(
                fontSize: 20, fontFamily: 'Lobster', color: Colors.cyanAccent),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'DESCRIPTION:\n' + widget.description,
            style: const TextStyle(fontSize: 20, color: Colors.tealAccent),
          ),
          GestureDetector(
            onTap: () async {
              if (widget.ownerId != FirebaseAuth.instance.currentUser?.uid) {
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
                await FirebaseFirestore.instance
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
                Fluttertoast.showToast(msg: 'Item Added to cart Successfully');
                // } else {
                //   Fluttertoast.showToast(
                //       msg: 'Item Has been deleted by the user');
                // }
              } else {
                Fluttertoast.showToast(
                    msg: "You cannot add your own product to cart");
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Container(
                decoration: BoxDecoration(
                    gradient: kGradientcolor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Center(child: Text('ADD TO CART')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
