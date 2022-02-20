import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:fcrit_mart/constants.dart';
import 'package:fcrit_mart/screens/user/get_product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        body: const TabBarView(
          children: [
            AllProductDetails(),
            Center(child: Text('My products')),
          ],
        ),
      ),
    );
  }
}

class CardswithDetails extends StatefulWidget {
  const CardswithDetails(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.imageUrl})
      : super(key: key);

  final String title;
  final String subtitle;
  final String imageUrl;

  @override
  State<CardswithDetails> createState() => _CardswithDetailsState();
}

class _CardswithDetailsState extends State<CardswithDetails> {
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
                return BottomPopup(
                    imageUrl: widget.imageUrl,
                    title: widget.title,
                    subtitle: widget.subtitle);
              },
            );
          },
          style: ListTileStyle.list,
          leading: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height,
            child: Image.network(widget.imageUrl),
          ),
          title: Text(widget.title),
          subtitle: Text(widget.subtitle),
          // trailing: Icon(Icons.more_vert),
          // isThreeLine: true,
        ),
      ),
    );
  }
}

class BottomPopup extends StatelessWidget {
  const BottomPopup(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.subtitle})
      : super(key: key);
  final String imageUrl;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Scaffold(
          backgroundColor: kScaffoldbackgroundcolor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.clear),
            ),
          ),
          bottomSheet: BottomSheet(
            onClosing: () {
              Navigator.of(context).pop();
            },
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2.5,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(imageUrl),
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'PermanentMarker',
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 25,
                        // fontFamily: 'PermanentMarker',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('Cart').doc().se
                },
                child: const Text(
                  'add to cart',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'See the item',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
