import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            letterSpacing: 5,
            fontFamily: 'PermanentMarker',
            fontSize: 30,
          ),
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
            height: 5,
          ),
          Text(
            'PRODUCT NAME:    ' + widget.productName.toUpperCase(),
            style: const TextStyle(fontSize: 25, fontFamily: 'PermanentMarker'),
          ),
          const SizedBox(
            height: 5,
          ),
          Text('Price:  ' + widget.price,
              style: const TextStyle(fontSize: 25, fontFamily: 'Lobster')),
          const SizedBox(
            height: 5,
          ),
          Text('MRP:  ' + widget.mrp,
              style: const TextStyle(fontSize: 25, fontFamily: 'Lobster')),
          const SizedBox(
            height: 10,
          ),
          Text('You Saved: $percentSave%'),
          const SizedBox(
            height: 10,
          ),
          Text(
            'DESCRIPTION:\n' + widget.description,
            style: const TextStyle(fontSize: 20),
          ),
          GestureDetector(
            onTap: () async {
              if (await FirebaseFirestore.instance
                  .collection('products')
                  .snapshots()
                  .contains(widget.id)) {
                FirebaseFirestore.instance
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
              } else {
                Fluttertoast.showToast(
                    msg: 'Item Has been deleted by the user');
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
