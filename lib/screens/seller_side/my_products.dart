import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Myproducts extends StatefulWidget {
  const Myproducts({Key? key}) : super(key: key);

  @override
  State<Myproducts> createState() => _MyproductsState();
}

class _MyproductsState extends State<Myproducts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            Details(),
            Center(child: Text('My products')),
          ],
        ),
      ),
    );
  }
}

class CardswithDetails extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: ListTile(
          style: ListTileStyle.list,
          leading: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height,
            child: Image.network(imageUrl),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          // trailing: Icon(Icons.more_vert),
          // isThreeLine: true,
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            var product = snapshot.data.docs;
            List<Widget> allProducts = [];
            for (var item in product) {
              final image = item.data()['file'];
              final productName = item.data()['Name'];
              final description = item.data()['description'];
              final mrp = item.data()['mrp'];
              final price = item.data()['price'];

              final tile = CardswithDetails(
                  title: productName,
                  subtitle: mrp.toString(),
                  imageUrl: image);
              allProducts.add(tile);
            }
            return ListView(
              children: allProducts,
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }
        return Divider(height: 0);
      },
    );
  }
}
