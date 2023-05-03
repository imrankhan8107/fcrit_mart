import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/appbar_button.dart';
import 'get_product_details.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
final _razorpay = Razorpay();

class MyOrders extends StatefulWidget {
  static const String id = 'my_order_page';
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  String name = '';
  String email = '';
  int mobilenumber = 0000000000;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Fluttertoast.showToast(msg: 'Payment Success');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(msg: 'Payment Fail');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore
            .collection('order')
            .where('buyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var items = snapshot.data.docs;
              List<Widget> myOrders = [];
              for (var item in items) {
                imageUrl = item.data()['imageUrl'];
                productName = item.data()['productName'];
                description = item.data()['description'];
                mrp = item.data()['mrp'];
                price = item.data()['price'];
                productId = item.data()['productId'];
                var sellerId = item.data()['sellerId'];
                var ownerId = item.data()['buyerId'];

                final myOrderTile = GestureDetector(
                  onTap: () async {
                    DocumentSnapshot documentSnapshot = await _firestore
                        .collection('users')
                        .doc(sellerId)
                        .get();
                    var snap = documentSnapshot.data() as Map<String, dynamic>;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text('Seller Details'),
                          actions: [
                            CupertinoDialogAction(
                              onPressed: () async {
                                print(item.data()['price']);
                                var options = {
                                  'key': 'rzp_test_52H71nU7cDRpJa',
                                  'amount': '${item.data()['price']}' '00',
                                  'name': '${item.data()['productName']}',
                                  'description':'${item.data()['description']}',
                                  "currency": "INR",
                                  'prefill': {
                                    'contact': '+91${['mobileno']}',
                                    'email': '${snap['email']}'
                                  }
                                };
                                try {
                                  _razorpay.open(options);
                                } catch (e) {
                                  // debugPrint(e);
                                  Fluttertoast.showToast(msg: e.toString());
                                }
                              },
                              child: Text('NAME:  ' +
                                  snap['username'].toString().toUpperCase()),
                            ),
                            CupertinoDialogAction(
                              onPressed: () {
                                launch('mailto:${snap['email']}?subject=Your%20Product%20Has%20been%20checked%20out&body=Your%Item%Has%');
                              },
                              child: Text('EMAIL:  ${snap['email']}'),
                            ),
                            CupertinoDialogAction(
                              child: Text(
                                  'Mobile No. :  ${snap['mobileno'].toString()}'),
                              onPressed: () {
                                launch(
                                    'https://wa.me/+91${snap['mobileno'].toString()}');
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: getImage(imageUrl)),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child:
                                    Text(productName.toString().toUpperCase()),
                              )),
                          Expanded(child: Text('PRICE: $price')),
                        ],
                      ),
                    ),
                  ),
                );
                myOrders.add(myOrderTile);
              }
              return myOrders.isNotEmpty
                  ? Scaffold(
                      appBar: AppBar(
                        title: Text('My Orders'),
                        leading: Appbarbutton(
                          ontapAppbar: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      body: SafeArea(
                        child: ListView(
                          children: myOrders,
                        ),
                      ),
                    )
                  : Scaffold(
                      appBar: AppBar(
                        title: const Text(
                          'Order Page',
                          style: TextStyle(fontSize: 30, fontFamily: 'Lobster'),
                        ),
                        leading: Appbarbutton(
                          ontapAppbar: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      body: Center(
                        child: Text('NO PRODUCTS ARE CHECKED OUT YET'),
                      ),
                    );
            }
          }
          return Center(child: Text('issue'));
        },
      ),
    );
  }
}
