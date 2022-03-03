import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../get_product_details.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
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
    getPermissions();
  }

  void getPermissions() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  @override
  Widget build(BuildContext context) {
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
              height: 150,
              width: 150,
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
                                    FirebaseMessaging.onMessage.listen((event) {
                                      print('message received');
                                      print('message data : ${event.data}');
                                      if (event.notification != null) {
                                        print(
                                            'Message also contained a notification: ${event.notification}');
                                      }
                                    });
                                    // String? refreshtoken =
                                    //     await firebaseMessaging.getToken();
                                    // print(refreshtoken);
                                    // firebaseMessaging.sendMessage(
                                    //   to: refreshtoken,
                                    // );
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
