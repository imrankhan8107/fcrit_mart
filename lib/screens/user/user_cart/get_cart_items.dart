import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../get_product_details.dart';
import 'carts_items_cards.dart';

// final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class GetCartItems extends StatefulWidget {
  GetCartItems({Key? key}) : super(key: key);

  @override
  State<GetCartItems> createState() => _GetCartItemsState();
}

class _GetCartItemsState extends State<GetCartItems> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getPermissions();
  }

  // void getPermissions() async {
  //   NotificationSettings settings = await firebaseMessaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   print('User granted permission: ${settings.authorizationStatus}');
  // }

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
                                    // FirebaseMessaging.onMessage.listen((event) {
                                    //   print('message received');
                                    //   print('message data : ${event.data}');
                                    //   if (event.notification != null) {
                                    //     print(
                                    //         'Message also contained a notification: ${event.notification}');
                                    //   }
                                    // });
                                    // String? refreshtoken =
                                    //     await firebaseMessaging.getToken();
                                    // print(refreshtoken);
                                    // firebaseMessaging.sendMessage(
                                    //   to: refreshtoken,
                                    // );
                                    //TODO: make an new collection named ORDERS and add a unique order id and ordertime along with buyer and sellers uids and then show contact details of seller to buyer and remove product from all products and add to soldout subcollection of seller and purchased subcollection of buyer
                                    for (var element in cartProducts) {
                                      if (ownerId != currentUserUid) {
                                        // showDialog(
                                        //     context: context,
                                        //     builder: (context) {
                                        //       return Center(
                                        //         child:
                                        //             CircularProgressIndicator(),
                                        //       );
                                        //     });
                                        String _uid = const Uuid().v1();
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
                                          // cc: ['cc@example.com'],
                                          // bcc: ['bcc@example.com'],
                                          // attachmentPaths: [
                                          //   '/path/to/attachment.zip'
                                          // ],
                                          isHTML: false,
                                        );

                                        await FlutterEmailSender.send(email);

                                        try {
                                          Fluttertoast.showToast(
                                              msg: 'Order Success');
                                          _firestore
                                              .collection('order')
                                              .doc(productId)
                                              .set({
                                            'orderId': _uid,
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
                                          // if (ownerId ==
                                          //     FirebaseAuth
                                          //         .instance.currentUser!.uid) {
                                          //   showDialog(
                                          //       context: context,
                                          //       builder: (context) {
                                          //         return AlertDialog(
                                          //           title: const Text(
                                          //               'Product Checked Out'),
                                          //           content: Text(
                                          //               'Your Product $productName has been checked out.\nPlease check Sold items.'),
                                          //           actions: [
                                          //             TextButton(
                                          //               onPressed: () {
                                          //                 Navigator.of(context)
                                          //                     .pop();
                                          //               },
                                          //               child: const Text('OK'),
                                          //             )
                                          //           ],
                                          //         );
                                          //       });
                                          // }
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
                                        } catch (e) {
                                          print(e.toString());
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
