import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

import '../get_product_details.dart';
import 'carts_items_cards.dart';

// final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final _razorpay = Razorpay();

class GetCartItems extends StatefulWidget {
  GetCartItems({Key? key}) : super(key: key);

  @override
  State<GetCartItems> createState() => _GetCartItemsState();
}

class _GetCartItemsState extends State<GetCartItems> {
  String name = '';
  String email = '';
  int mobilenumber = 0000000000;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Fluttertoast.showToast(
        msg: 'Order Success');
    _firestore
        .collection('order')
        .doc(productId)
        .set({
      'orderId': Uuid().v1(),
      'checkoutTime': DateTime.now(),
      'sellerId': ownerId,
      'buyerId': FirebaseAuth
          .instance.currentUser!.uid,
      'productName': productName,
      'productId': productId,
      'description': description,
      'imageUrl': imageUrl,
      'mrp': mrp,
      'price': price,
    });

    _firestore
        .collection('users')
        .doc(FirebaseAuth
        .instance.currentUser?.uid)
        .collection('Cart')
        .doc(productId)
        .delete();
    _firestore
        .collection('products')
        .doc(productId)
        .delete();
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
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _razorpay.clear();
  }
  @override
  Widget build(BuildContext context) {
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
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
              height: 200,
              width: 200,
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
              ownerId = item.data()['ownerId'];
              totalAmount = totalAmount + int.parse(price);
              // print(ownerId);
              print(totalAmount);

              final tile = CartItemCards(
                productname: productName,
                mrp: mrp,
                imageUrl: imageUrl,
                price: price,
                description: description,
                productId: productId,
                ownerId: ownerId,
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
                                  onPressed: () async {

                                    for (var element in cartProducts) {
                                      if (ownerId != currentUserUid) {
                                        DocumentSnapshot snapshot =
                                            await _firestore
                                                .collection('users')
                                                .doc(ownerId)
                                                .get();
                                        var snap = snapshot.data()
                                            as Map<String, dynamic>;
                                        final Email email = Email(
                                          body:
                                              'Your product $productName  has been checked out. Please check SOLD OUT section to get more details in the App',
                                          subject: 'CheckOut Details',
                                          recipients: ['${snap['email']}'],
                                          isHTML: false,
                                        );

                                        await FlutterEmailSender.send(email);
                                        var options = {
                                          'key': 'rzp_test_W8ouhkUI8IPXiQ',
                                          'amount': '$price' '00',
                                          'name': '$productName',
                                          'description':'$description',
                                          "currency": "INR",
                                          'prefill': {
                                            'contact': '+91$mobilenumber',
                                            'email': '$email'
                                          }
                                        };
                                        try {
                                          _razorpay.open(options);
                                          _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);

                                        } catch (e) {
                                          _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
                                          Fluttertoast.showToast(
                                              msg: 'Order Unsuccessful');
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                          msg:
                                              "YOU CAN'T BUY YOUR OWN PRODUCTS",
                                        );
                                      }
                                    }
                                  },
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
                              style: TextStyle(fontSize: 18),
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
