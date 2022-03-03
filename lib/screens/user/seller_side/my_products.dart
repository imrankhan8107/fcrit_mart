import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/screens/user/get_product_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/bottom_popup.dart';
import '../../../constants.dart';
import '../../see_product.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Myproducts extends StatefulWidget {
  const Myproducts({Key? key}) : super(key: key);

  @override
  State<Myproducts> createState() => _MyproductsState();
}

class _MyproductsState extends State<Myproducts> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Appbarbutton(
            ontapAppbar: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Seller page',
            style: TextStyle(fontSize: 18),
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'All products',
              ),
              Tab(
                text: 'My Items',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllProductDetails(),
            StreamBuilder(
              stream: _firestore
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('myProducts')
                  .orderBy('publishTime')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasData) {
                    var product = snapshot.data.docs;
                    List<Widget> myProducts = [
                      // TextButton(
                      //     onPressed: () {
                      //       showModalBottomSheet(
                      //         context: context,
                      //         builder: (context) {
                      //           return Scaffold(
                      //             appBar: AppBar(
                      //               title: const Text(
                      //                 'Filter Options',
                      //                 style: TextStyle(fontSize: 25),
                      //               ),
                      //             ),
                      //             body: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.stretch,
                      //               children: [
                      //                 TextButton(
                      //                     onPressed: () {
                      //                       setState(() {
                      //                         sortItemsBy = 'price';
                      //                       });
                      //                     },
                      //                     child: const Text('price')),
                      //                 TextButton(
                      //                     onPressed: () {
                      //                       setState(() {
                      //                         sortItemsBy = 'mrp';
                      //                       });
                      //                     },
                      //                     child: Text('mrp')),
                      //                 TextButton(
                      //                     onPressed: () {
                      //                       setState(() {
                      //                         sortItemsBy = 'publishTime';
                      //                       });
                      //                     },
                      //                     child: Text('publishTime'))
                      //               ],
                      //             ),
                      //             bottomSheet: Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Row(
                      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                 children: [
                      //                   sortInDescending
                      //                       ? Text('Sorted in Descending')
                      //                       : Text('Sorted in Ascending'),
                      //                   // Switch(
                      //                   //     value: sortInDescending,
                      //                   //     onChanged: (bool val) {
                      //                   //       setState(() {
                      //                   //         sortInDescending = val;
                      //                   //       });
                      //                   //     }),
                      //                   CupertinoSwitch(
                      //                     value: sortInDescending,
                      //                     onChanged: (bool value) {
                      //                       setState(() {
                      //                         sortInDescending = value;
                      //                         Navigator.of(context).pop();
                      //                       });
                      //                     },
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //           );
                      //         },
                      //       );
                      //     },
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 10),
                      //       child: Row(
                      //         children: [
                      //           Text(
                      //             sortItemsBy,
                      //             style: TextStyle(fontSize: 17),
                      //           ),
                      //           sortInDescending
                      //               ? Icon(Icons.arrow_downward)
                      //               : Icon(Icons.arrow_upward),
                      //         ],
                      //       ),
                      //     ))
                    ];
                    for (var item in product) {
                      imageUrl = item.data()['file'];
                      productName = item.data()['Name'];
                      description = item.data()['description'];
                      mrp = item.data()['mrp'];
                      price = item.data()['price'];
                      productId = item.data()['id'];
                      ownerId = item.data()['owner'];

                      final tile = MyProductCards(
                        productname: productName,
                        mrp: mrp.toString(),
                        imageUrl: imageUrl,
                        description: description,
                        price: price.toString(),
                        productId: productId,
                        ownerid: ownerId,
                      );

                      myProducts.add(tile);
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
                    return myProducts.isNotEmpty
                        ? ListView(
                            children: myProducts,
                          )
                        : const Center(
                            child: Text(
                            'You have not uploaded and items',
                            style:
                                TextStyle(fontSize: 25, fontFamily: 'Lobster'),
                          ));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                }
                return const Divider(height: 0);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyProductCards extends StatefulWidget {
  const MyProductCards({
    Key? key,
    required this.productname,
    required this.mrp,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.productId,
    required this.ownerid,
  }) : super(key: key);

  final String productname;
  final String mrp;
  final String price;
  final String imageUrl;
  final String description;
  final String productId;
  final String ownerid;

  @override
  State<MyProductCards> createState() => _MyProductCardsState();
}

class _MyProductCardsState extends State<MyProductCards> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: ListTile(
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return MyProductPopUp(
                  imageUrl: widget.imageUrl,
                  productName: widget.productname,
                  mrp: widget.mrp,
                  price: widget.price,
                  description: widget.description,
                  id: widget.productId,
                  ownerId: widget.ownerid,
                );
              },
            );
          },
          style: ListTileStyle.list,
          leading: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height,
            child: getImage(widget.imageUrl),
          ),
          title: Text(widget.productname),
          subtitle: Text(widget.price),
          // isThreeLine: true,
        ),
      ),
    );
  }
}

class MyProductPopUp extends StatefulWidget {
  const MyProductPopUp(
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
  State<MyProductPopUp> createState() => _MyProductPopUpState();
}

class _MyProductPopUpState extends State<MyProductPopUp>
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
                  },
                  child: const Text(
                    'Update details',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, ProductPage.id);

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