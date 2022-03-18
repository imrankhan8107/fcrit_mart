import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcrit_mart/components/appbar_button.dart';
import 'package:flutter/material.dart';

import '../../../components/item_card.dart';
import '../get_product_details.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchBox = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchBox.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> searchResults = [];
    return Scaffold(
      appBar: AppBar(
        leading: Appbarbutton(
          ontapAppbar: () {
            Navigator.of(context).pop();
          },
        ),
        title: TextFormField(
          controller: searchBox,
          decoration: InputDecoration(
            hintText: 'Search',
            border: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
          ),
          onFieldSubmitted: (String val) {
            print(val);
            print(searchBox.text);
            setState(() {});
          },
        ),
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection('products')
            .where('Name', isGreaterThanOrEqualTo: searchBox.text)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData && searchBox.text.isNotEmpty) {
              // getImage()
              var searchItem = snapshot.data.docs;
              for (var item in searchItem) {
                imageUrl = item.data()['file'];
                productName = item.data()['Name'];
                description = item.data()['description'];
                mrp = item.data()['mrp'];
                price = item.data()['price'];
                productId = item.data()['id'];
                ownerId = item.data()['owner'];

                final tile = CardswithDetails(
                  productname: productName,
                  mrp: mrp.toString(),
                  imageUrl: imageUrl,
                  description: description,
                  price: price.toString(),
                  productId: productId,
                  ownerid: ownerId,
                );

                searchResults.add(tile);
              }
              return searchResults.isEmpty
                  ? Center(
                      child: Text(
                        'No Items Found',
                        style: TextStyle(fontSize: 30),
                      ),
                    )
                  : ListView(
                      children: searchResults,
                    );
            }
          }
          return const Center(child: Text('Search Products'));
        },
      ),
    );
  }
}
